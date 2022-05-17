defmodule Baz.Repo.Migrations.CreateCollections do
  use Ecto.Migration

  def change do
    create table(:collections) do
      add :venue, :text, null: false
      add :slug, :text, null: false
      add :description, :text
      add :image_uri, :text
      add :banner_image_uri, :text

      timestamps()
    end

    create index(:collections, [:slug], unique: true)
  end
end
