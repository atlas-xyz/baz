defmodule Baz.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create_query = """
    CREATE TYPE event_type AS ENUM (
      'item_listed',
      'item_sold',
      'item_transferred',
      'item_metadata_update',
      'item_canceled',
      'item_received_offer',
      'item_received_bid'
    )
    """
    drop_query = "DROP TYPE event_type"
    execute(create_query, drop_query)

    create table(:events) do
      add :venue, :text, null: false
      add :event_type, :event_type, null: false
      add :event_timestamp, :utc_datetime

      timestamps()
    end

  end
end
