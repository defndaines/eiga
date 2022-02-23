defmodule IMDbData.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people, primary_key: false) do
      add(:nconst, :string, primary_key: true)
      add(:name, :string, null: false)
      add(:birth_year, :integer)
      add(:death_year, :integer)
      add(:professions, :string, null: false)

      timestamps()
    end
  end
end
