defmodule Baz.TestSupport.Factories.CollectionFactory do
  @spec create_collection(map) :: term
  # @spec create_collection(map) :: {:ok, Ecto.Changeset.t()} | {:error, term}
  def create_collection(attrs) do
    %Baz.Collections.Collection{}
    |> Baz.Collections.Collection.changeset(attrs)
    |> Baz.Repo.insert()
  end
end
