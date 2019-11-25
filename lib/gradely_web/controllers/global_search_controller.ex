defmodule GradelyWeb.GlobalSearchController do
  use GradelyWeb, :controller

  def search(conn, params) do
    IO.inspect params
    render(conn, "index.html")
  end


end
