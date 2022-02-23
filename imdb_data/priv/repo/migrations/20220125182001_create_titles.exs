defmodule IMDbData.Repo.Migrations.CreateTitles do
  use Ecto.Migration

  def change do
    create table(:titles, primary_key: false) do
      add(:tconst, :string, primary_key: true)
      add(:type, :string, null: false)
      add(:primary_title, :string, null: false)
      add(:original_title, :string, null: false)
      add(:adult, :boolean, default: false, null: false)
      add(:start_year, :integer)
      add(:end_year, :integer)
      add(:runtime, :integer)
      add(:genres, :string)

      timestamps()
    end
  end
end
