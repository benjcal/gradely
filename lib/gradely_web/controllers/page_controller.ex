defmodule GradelyWeb.PageController do
  use GradelyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
