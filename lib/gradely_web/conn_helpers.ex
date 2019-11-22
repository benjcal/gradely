defmodule GradelyWeb.ConnHelpers do

  def get_user(%Plug.Conn{} = conn) do
    conn
    |> Map.get(:assigns)
    |> Map.get(:current_user)
  end

  def get_user_id(%Plug.Conn{} = conn) do
    get_user(conn)
    |> Map.get(:id)
  end
end
