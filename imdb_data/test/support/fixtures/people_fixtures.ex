defmodule IMDbData.PeopleFixtures do
  @moduledoc """
  This module defines test helpers for creating entities via the `IMDbData.People` context.
  """

  @doc """
  Generate a person.
  """
  def person_fixture(attrs \\ %{}) do
    {:ok, person} =
      attrs
      |> Enum.into(%{
        birth_year: 1942,
        death_year: nil,
        name: "Some Name",
        nconst: "nm9999999",
        professions: "actress,director"
      })
      |> IMDbData.People.create_person()

    person
  end
end
