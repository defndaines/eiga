defmodule EigaWeb.PageController do
  use EigaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
