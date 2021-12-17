defmodule Eiga.Repo.Migrations.CreateMoviesTable do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\"")

    create table(:movies, primary_key: false) do
      add(:movie_id, :uuid,
        primary_key: true,
        null: false,
        default: fragment("uuid_generate_v4()")
      )

      add(:short_title, :string, null: false)
      add(:title, :string, null: false)
      add(:year, :integer, null: false)
      add(:country, :string, default: "U.S.")

      timestamps()
    end

    create(index(:movies, [:short_title], unique: true))
  end
end
