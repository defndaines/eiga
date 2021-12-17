defmodule Eiga.Repo.Migrations.CreateReviewsTable do
  use Ecto.Migration

  def change do
    create table(:reviews, primary_key: false) do
      add(:review_id, :uuid,
        primary_key: true,
        null: false,
        default: fragment("uuid_generate_v4()")
      )

      add(:short_title, references(:movies, column: :short_title, type: :string), null: false)
      add(:location, :string, null: false, default: "DVD at Home")
      add(:view_date, :date)
      add(:text, :text, null: false)

      timestamps()
    end
  end
end
