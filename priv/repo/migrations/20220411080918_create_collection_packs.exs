defmodule Baz.Repo.Migrations.CreateCollectionPacks do
  use Ecto.Migration

  def change do
    create table(:collection_packs) do
      add :slug, :text, null: false
      add :description, :text
      add :image_uri, :text
      add :banner_image_uri, :text

      timestamps()
    end

    create index(:collection_packs, [:slug], unique: true)
  end
end
