defmodule GradelyWeb.ConnHelpers do

  def get_user(conn = %Plug.Conn{}) do
    conn
    |> Map.get(:assigns)
    |> Map.get(:current_user)
  end

  def get_user_id(conn = %Plug.Conn{}) do
    get_user(conn)
    |> Map.get(:id)
  end
end
