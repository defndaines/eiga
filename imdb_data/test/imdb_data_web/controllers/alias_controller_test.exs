defmodule IMDbDataWeb.AliasControllerTest do
  use IMDbDataWeb.ConnCase

  import IMDbData.MoviesFixtures

  @create_attrs %{
    attributes: "some attributes",
    language: "some language",
    region: "some region",
    title: "some title",
    types: "some types"
  }
  @update_attrs %{
    attributes: "some updated attributes",
    language: "some updated language",
    region: "some updated region",
    title: "some updated title",
    types: "some updated types"
  }
  @invalid_attrs %{
    attributes: nil,
    language: nil,
    region: nil,
    tconst: nil,
    title: nil,
    types: nil
  }

  describe "index" do
    test "lists all aliases", %{conn: conn} do
      conn = get(conn, Routes.alias_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Aliases"
    end
  end

  describe "new alias" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.alias_path(conn, :new))
      assert html_response(conn, 200) =~ "New Alias"
    end
  end

  describe "create alias" do
    test "redirects to show when data is valid", %{conn: conn} do
      %{tconst: tconst} = title_fixture()

      conn =
        post(conn, Routes.alias_path(conn, :create),
          alias: Map.put(@create_attrs, :tconst, tconst)
        )

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.alias_path(conn, :show, id)

      conn = get(conn, Routes.alias_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Alias"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.alias_path(conn, :create), alias: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Alias"
    end
  end

  describe "edit alias" do
    setup [:create_alias]

    test "renders form for editing chosen alias", %{conn: conn, alias: alias} do
      conn = get(conn, Routes.alias_path(conn, :edit, alias))
      assert html_response(conn, 200) =~ "Edit Alias"
    end
  end

  describe "update alias" do
    setup [:create_alias]

    test "redirects when data is valid", %{conn: conn, alias: alias} do
      conn = put(conn, Routes.alias_path(conn, :update, alias), alias: @update_attrs)
      assert redirected_to(conn) == Routes.alias_path(conn, :show, alias)

      conn = get(conn, Routes.alias_path(conn, :show, alias))
      assert html_response(conn, 200) =~ "some updated attributes"
    end

    test "renders errors when data is invalid", %{conn: conn, alias: alias} do
      conn = put(conn, Routes.alias_path(conn, :update, alias), alias: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Alias"
    end
  end

  describe "delete alias" do
    setup [:create_alias]

    test "deletes chosen alias", %{conn: conn, alias: alias} do
      conn = delete(conn, Routes.alias_path(conn, :delete, alias))
      assert redirected_to(conn) == Routes.alias_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.alias_path(conn, :show, alias))
      end
    end
  end

  defp create_alias(_) do
    %{tconst: tconst} = title_fixture()
    alias = alias_fixture(%{tconst: tconst})
    %{alias: alias}
  end
end
