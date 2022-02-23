defmodule IMDbDataWeb.TitleControllerTest do
  use IMDbDataWeb.ConnCase

  import IMDbData.MoviesFixtures

  @create_attrs %{
    adult: true,
    end_year: 1942,
    genres: "some genres",
    original_title: "some
  original_title",
    primary_title: "some primary_title",
    runtime: 42,
    start_year: 1942,
    tconst: "tt9999999",
    type: "some type"
  }
  @update_attrs %{
    adult: false,
    end_year: 1943,
    genres: "some updated genres",
    original_title: "some updated original_title",
    primary_title: "some updated primary_title",
    runtime: 43,
    start_year: 1943,
    tconst: "tt9999999",
    type: "some updated type"
  }
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

  describe "index" do
    test "lists all titles", %{conn: conn} do
      conn = get(conn, Routes.title_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Titles"
    end
  end

  describe "new title" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.title_path(conn, :new))
      assert html_response(conn, 200) =~ "New Title"
    end
  end

  describe "create title" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.title_path(conn, :create), title: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.title_path(conn, :show, id)

      conn = get(conn, Routes.title_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Title"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.title_path(conn, :create), title: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Title"
    end
  end

  describe "edit title" do
    setup [:create_title]

    test "renders form for editing chosen title", %{conn: conn, title: title} do
      conn = get(conn, Routes.title_path(conn, :edit, title))
      assert html_response(conn, 200) =~ "Edit Title"
    end
  end

  describe "update title" do
    setup [:create_title]

    test "redirects when data is valid", %{conn: conn, title: title} do
      conn = put(conn, Routes.title_path(conn, :update, title), title: @update_attrs)
      assert redirected_to(conn) == Routes.title_path(conn, :show, title)

      conn = get(conn, Routes.title_path(conn, :show, title))
      assert html_response(conn, 200) =~ "some updated genres"
    end

    test "renders errors when data is invalid", %{conn: conn, title: title} do
      conn = put(conn, Routes.title_path(conn, :update, title), title: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Title"
    end
  end

  describe "delete title" do
    setup [:create_title]

    test "deletes chosen title", %{conn: conn, title: title} do
      conn = delete(conn, Routes.title_path(conn, :delete, title))
      assert redirected_to(conn) == Routes.title_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.title_path(conn, :show, title))
      end
    end
  end

  defp create_title(_) do
    title = title_fixture()
    %{title: title}
  end
end
