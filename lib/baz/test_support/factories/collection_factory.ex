defmodule Baz.TestSupport.Factories.CollectionFactory do
  @spec create_collection(map) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  def create_collection(attrs) do
    %Baz.Collections.Collection{}
    |> Baz.Collections.Collection.changeset(attrs)
    |> Baz.Repo.insert()
  end
end
