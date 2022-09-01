defmodule Baz.CollectionEventImports.Jobs.PullCollectionEventsByPage do
  @moduledoc """
  Fetch collection event data from a venue and normalize before passing through the sink pipeline
  """

  use Oban.Worker, queue: :imports
  import Baz.FormatLogger

  defmodule Input do
    defstruct ~w[import retries sinks page_number page_cursor]a
  end

  @impl Oban.Worker
  def perform(%Oban.Job{
        args: %{
          "collection_event_import_id" => import_id,
          "retries" => retries,
          "page_number" => page_number,
          "page_cursor" => page_cursor
        }
      }) do
    event_import = Baz.CollectionEventImports.get_collection_event_import!(import_id)
    event_sinks = Baz.NormalizedSinks.get_collection_event_normalized_sinks()

    try do
      %Input{
        import: event_import,
        retries: retries,
        sinks: event_sinks,
        page_number: page_number,
        page_cursor: page_cursor
      }
      |> ensure_import_started()
      |> fetch_and_upsert()
      |> enqueue_next_page()
      |> complete_import_on_last_page()
    rescue
      e ->
        "unhandled error pulling collection events by page venue=~s, slug=~s, token_ids=~w, import_id=~w, error=~s, stacktrace=~s"
        |> log_error([
          event_import.venue,
          event_import.slug,
          event_import.token_ids,
          event_import.id,
          inspect(e),
          inspect(__STACKTRACE__)
        ])
    end
  rescue
    e ->
      "unhandled error pulling collection events by page error=~s, stacktrace=~s"
      |> log_error([inspect(e), inspect(__STACKTRACE__)])
  end

  defp ensure_import_started(input) do
    input =
      if input.page_number == 0 do
        "start execution of collection events import id=~w" |> log_info([input.import.id])
        {:ok, event_import} = update_import_status(input.import, "executing")
        %{input | import: event_import}
      else
        input
      end

    "pull collection events by page=~w, venue=~s, slug=~s, token_ids=~w, import_id=~w"
    |> log_info([
      input.page_number,
      input.import.venue,
      input.import.slug,
      input.import.token_ids,
      input.import.id
    ])

    input
  end

  defp fetch_and_upsert(input) do
    case fetch(input.import, input.page_cursor) do
      %Baz.Page{} = page ->
        multi = Ecto.Multi.new()

        import_page_attrs = %{
          page_number: input.page_number,
          next_page_cursor: page.next_page_cursor
        }

        import_page = Ecto.build_assoc(input.import, :pages, import_page_attrs)
        multi = Ecto.Multi.insert(multi, :import_page, import_page)

        multi =
          page.data
          |> Enum.with_index()
          |> Enum.reduce(
            multi,
            fn {event, index}, multi ->
              Ecto.Multi.insert(multi, {:collection_event, index}, event)
            end
          )


        Logger.info("receive_collection_event_import MULTI #{inspect(multi)}")
        result = input.sinks |> Enum.map(fn s -> s.receive_collection_event_import(multi) end)

        {input, {:ok, result}, import_page}

      {:error, reason} = error ->
        "could not pull collection events for page=~w, venue=~s, slug=~s, token_ids=~w, import_id=~w, reason=~s"
        |> log_error([
          input.page_number,
          input.import.venue,
          input.import.slug,
          input.import.token_ids,
          input.import.id,
          reason |> inspect
        ])

        {input, error, nil}
    end
  end

  defp enqueue_next_page({input, fetch_and_upsert_result, import_page} = state) do
    case fetch_and_upsert_result do
      {:ok, _result} ->
        if import_page.next_page_cursor != nil do
          %{
            collection_event_import_id: input.import.id,
            retries: 0,
            page_number: import_page.page_number + 1,
            page_cursor: import_page.next_page_cursor
          }
          |> Baz.CollectionEventImports.Jobs.PullCollectionEventsByPage.new()
          |> Oban.insert()
        end

      {:error, _reason} ->
        if input.retries < input.import.max_retries do
          retry_attempt = input.retries + 1
          schedule_in = Integer.pow(retry_attempt, 2)

          "retry ~w/~w pull collection events by page=~w in ~w seconds venue=~s, slug=~s, token_ids=~w, import_id=~w"
          |> log_warn([
            retry_attempt,
            input.import.max_retries,
            input.page_number,
            schedule_in,
            input.import.venue,
            input.import.slug,
            input.import.token_ids,
            input.import.id
          ])

          %{
            collection_event_import_id: input.import.id,
            retries: retry_attempt,
            schedule_in: schedule_in,
            page_number: input.page_number,
            page_cursor: input.page_cursor
          }
          |> Baz.CollectionEventImports.Jobs.PullCollectionEventsByPage.new()
          |> Oban.insert()
        else
          "max retry attempts ~w/~w reached pulling collection events by page=~w, venue=~s, slug=~s, token_ids=~w, import_id=~w"
          |> log_error([
            input.retries,
            input.import.max_retries,
            input.page_number,
            input.import.venue,
            input.import.slug,
            input.import.token_ids,
            input.import.id
          ])
        end
    end

    state
  end

  defp complete_import_on_last_page({input, fetch_and_upsert_result, import_page}) do
    if import_page && import_page.next_page_cursor == nil do
      "complete execution of collection events import id=~w" |> log_info([input.import.id])
      {:ok, _event_import} = update_import_status(input.import, "completed")
    end

    fetch_and_upsert_result
  end

  defp update_import_status(event_import, status) do
    Baz.CollectionEventImports.update_collection_event_import(event_import, %{status: status})
  end

  defp fetch(event_import, page_cursor) do
    try do
      venue = Baz.Venues.get_venue!(event_import.venue)

      Baz.VenueAdapter.fetch_collection_event_page_by_slug(
        venue,
        event_import.slug,
        event_import.token_ids,
        page_cursor
      )
    rescue
      reason -> {:error, reason}
    end
  end
end
