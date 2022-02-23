defmodule IMDbData.PeopleTest do
  use IMDbData.DataCase

  alias IMDbData.People

  describe "people" do
    alias IMDbData.People.Person

    import IMDbData.PeopleFixtures

    @invalid_attrs %{birth_year: nil, death_year: nil, name: nil, nconst: nil, professions: nil}

    test "list_people/0 returns all people" do
      person = person_fixture()
      assert People.list_people() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert People.get_person!(person.nconst) == person
    end

    test "create_person/1 with valid data creates a person" do
      valid_attrs = %{
        birth_year: 42,
        death_year: 42,
        name: "some name",
        nconst: "nm9999999",
        professions: "some professions"
      }

      assert {:ok, %Person{} = person} = People.create_person(valid_attrs)
      assert person.birth_year == 42
      assert person.death_year == 42
      assert person.name == "some name"
      assert person.nconst == "nm9999999"
      assert person.professions == "some professions"
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = People.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()

      update_attrs = %{
        birth_year: 43,
        death_year: 43,
        name: "some updated name",
        nconst: "nm9999999",
        professions: "some updated professions"
      }

      assert {:ok, %Person{} = person} = People.update_person(person, update_attrs)
      assert person.birth_year == 43
      assert person.death_year == 43
      assert person.name == "some updated name"
      assert person.nconst == "nm9999999"
      assert person.professions == "some updated professions"
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = People.update_person(person, @invalid_attrs)
      assert person == People.get_person!(person.nconst)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = People.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> People.get_person!(person.nconst) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = People.change_person(person)
    end
  end
end
