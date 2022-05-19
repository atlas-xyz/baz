defmodule Baz.Repo.Migrations.CreateOrderBooks do
  use Ecto.Migration

  def change do
    create_query = """
    CREATE TYPE order_book_side_type AS ENUM (
      'offer',
      'listing',
      'collection_offer'
    )
    """
    drop_query = "DROP TYPE order_book_side_type"
    execute(create_query, drop_query)

    create table(:order_books) do
      add :uri, :text, null: false
      add :side, :order_book_side_type, null: false
      add :description, :text
      add :image_uri, :text
      add :banner_image_uri, :text

      timestamps()
    end

    create index(:order_books, [:slug], unique: true)
  end
end
