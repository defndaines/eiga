defmodule IMDbDataWeb.AliasController do
  use IMDbDataWeb, :controller

  alias IMDbData.Movies
  alias IMDbData.Movies.Alias

  def index(conn, _params) do
    aliases = Movies.list_aliases()
    render(conn, "index.html", aliases: aliases)
  end

  def new(conn, _params) do
    changeset = Movies.change_alias(%Alias{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"alias" => alias_params}) do
    case Movies.create_alias(alias_params) do
      {:ok, alias} ->
        conn
        |> put_flash(:info, "Alias created successfully.")
        |> redirect(to: Routes.alias_path(conn, :show, alias))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    alias = Movies.get_alias!(id)
    render(conn, "show.html", alias: alias)
  end

  def edit(conn, %{"id" => id}) do
    alias = Movies.get_alias!(id)
    changeset = Movies.change_alias(alias)
    render(conn, "edit.html", alias: alias, changeset: changeset)
  end

  def update(conn, %{"id" => id, "alias" => alias_params}) do
    alias = Movies.get_alias!(id)

    case Movies.update_alias(alias, alias_params) do
      {:ok, alias} ->
        conn
        |> put_flash(:info, "Alias updated successfully.")
        |> redirect(to: Routes.alias_path(conn, :show, alias))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", alias: alias, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    alias = Movies.get_alias!(id)
    {:ok, _alias} = Movies.delete_alias(alias)

    conn
    |> put_flash(:info, "Alias deleted successfully.")
    |> redirect(to: Routes.alias_path(conn, :index))
  end
end
