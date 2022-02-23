defmodule IMDbData.MoviesTest do
  use IMDbData.DataCase

  alias IMDbData.Movies
  alias IMDbData.Movies.Title

  import IMDbData.MoviesFixtures

  describe "titles" do
    @invalid_attrs %{
      adult: nil,
      end_year: nil,
      genres: nil,
      original_title: nil,
      primary_title: nil,
      runtime: nil,
      start_year: nil,
      tconst: nil,
      type: nil
    }

    test "list_titles/0 returns all titles" do
      title = title_fixture()
      assert Movies.list_titles() == [title]
    end

    test "get_title!/1 returns the title with given tconst" do
      title = title_fixture()
      assert Movies.get_title!(title.tconst) == title
    end

    test "create_title/1 with valid data creates a title" do
      valid_attrs = %{
        adult: true,
        end_year: 1942,
        genres: "some genres",
        original_title: "some original_title",
        primary_title: "some primary_title",
        runtime: 42,
        start_year: 1942,
        tconst: "some tconst",
        type: "some type"
      }

      assert {:ok, %Title{} = title} = Movies.create_title(valid_attrs)
      assert title.adult == true
      assert title.end_year == 1942
      assert title.genres == "some genres"
      assert title.original_title == "some original_title"
      assert title.primary_title == "some primary_title"
      assert title.runtime == 42
      assert title.start_year == 1942
      assert title.tconst == "some tconst"
      assert title.type == "some type"
    end

    test "create_title/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movies.create_title(@invalid_attrs)
    end

    test "update_title/2 with valid data updates the title" do
      title = title_fixture()

      update_attrs = %{
        adult: false,
        end_year: 1943,
        genres: "some updated genres",
        original_title: "some updated original_title",
        primary_title: "some updated primary_title",
        runtime: 43,
        start_year: 1943,
        tconst: "some updated tconst",
        type: "some updated type"
      }

      assert {:ok, %Title{} = title} = Movies.update_title(title, update_attrs)
      assert title.adult == false
      assert title.end_year == 1943
      assert title.genres == "some updated genres"
      assert title.original_title == "some updated original_title"
      assert title.primary_title == "some updated primary_title"
      assert title.runtime == 43
      assert title.start_year == 1943
      assert title.tconst == "some updated tconst"
      assert title.type == "some updated type"
    end

    test "update_title/2 with invalid data returns error changeset" do
      title = title_fixture()
      assert {:error, %Ecto.Changeset{}} = Movies.update_title(title, @invalid_attrs)
      assert title == Movies.get_title!(title.tconst)
    end

    test "delete_title/1 deletes the title" do
      title = title_fixture()
      assert {:ok, %Title{}} = Movies.delete_title(title)
      assert_raise Ecto.NoResultsError, fn -> Movies.get_title!(title.tconst) end
    end

    test "change_title/1 returns a title changeset" do
      title = title_fixture()
      assert %Ecto.Changeset{} = Movies.change_title(title)
    end
  end

  describe "aliases" do
    alias IMDbData.Movies.Alias

    setup do
      title = title_fixture()
      {:ok, tconst: title.tconst}
    end

    @invalid_attrs %{
      attributes: nil,
      language: nil,
      region: nil,
      tconst: nil,
      title: nil,
      types: nil
    }

    test "list_aliases/0 returns all aliases", %{tconst: tconst} do
      alias = alias_fixture(%{tconst: tconst})
      assert Movies.list_aliases() == [alias]
    end

    test "get_alias!/1 returns the alias with given id", %{tconst: tconst} do
      alias = alias_fixture(%{tconst: tconst})
      assert Movies.get_alias!(alias.id) == alias
    end

    test "create_alias/1 with valid data creates a alias", %{tconst: tconst} do
      valid_attrs = %{
        attributes: "some attributes",
        language: "some language",
        region: "some region",
        tconst: tconst,
        title: "some title",
        types: "some types"
      }

      assert {:ok, %Alias{} = alias} = Movies.create_alias(valid_attrs)
      assert alias.attributes == "some attributes"
      assert alias.language == "some language"
      assert alias.region == "some region"
      assert alias.tconst == tconst
      assert alias.title == "some title"
      assert alias.types == "some types"
    end

    test "create_alias/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movies.create_alias(@invalid_attrs)
    end

    test "update_alias/2 with valid data updates the alias", %{tconst: tconst} do
      alias = alias_fixture(%{tconst: tconst})

      update_attrs = %{
        attributes: "some updated attributes",
        language: "some updated language",
        region: "some updated region",
        title: "some updated title",
        types: "some updated types"
      }

      assert {:ok, %Alias{} = alias} = Movies.update_alias(alias, update_attrs)
      assert alias.attributes == "some updated attributes"
      assert alias.language == "some updated language"
      assert alias.region == "some updated region"
      assert alias.tconst == tconst
      assert alias.title == "some updated title"
      assert alias.types == "some updated types"
    end

    test "update_alias/2 with invalid data returns error changeset" do
      alias = alias_fixture()
      assert {:error, %Ecto.Changeset{}} = Movies.update_alias(alias, @invalid_attrs)
      assert alias == Movies.get_alias!(alias.id)
    end

    test "delete_alias/1 deletes the alias", %{tconst: tconst} do
      alias = alias_fixture(%{tconst: tconst})
      assert {:ok, %Alias{}} = Movies.delete_alias(alias)
      assert_raise Ecto.NoResultsError, fn -> Movies.get_alias!(alias.id) end
    end

    test "change_alias/1 returns a alias changeset", %{tconst: tconst} do
      alias = alias_fixture(%{tconst: tconst})
      assert %Ecto.Changeset{} = Movies.change_alias(alias)
    end
  end

  describe "reviews" do
    alias IMDbData.Movies.Review

    import IMDbData.MoviesFixtures

    @invalid_attrs %{rating: nil, tconst: nil, votes: nil}

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert Movies.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture()
      assert Movies.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      valid_attrs = %{rating: 1.5, tconst: "some tconst", votes: 42}

      assert {:ok, %Review{} = review} = Movies.create_review(valid_attrs)
      assert review.rating == 1.5
      assert review.tconst == "some tconst"
      assert review.votes == 42
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movies.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      update_attrs = %{rating: 6.7, tconst: "some updated tconst", votes: 43}

      assert {:ok, %Review{} = review} = Movies.update_review(review, update_attrs)
      assert review.rating == 6.7
      assert review.tconst == "some updated tconst"
      assert review.votes == 43
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()
      assert {:error, %Ecto.Changeset{}} = Movies.update_review(review, @invalid_attrs)
      assert review == Movies.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = Movies.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> Movies.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = Movies.change_review(review)
    end
  end
end
