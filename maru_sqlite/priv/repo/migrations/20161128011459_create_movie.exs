defmodule Eiga.Repo.Migrations.CreateMovie do
  use Ecto.Migration

  def change do
    create table(:movie) do
      add :title, :string
      add :short_title, :string
      add :year, :integer
      add :country, :string
    end
  end
end
