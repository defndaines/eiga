defmodule IMDbDataWeb.PageController do
  use IMDbDataWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
