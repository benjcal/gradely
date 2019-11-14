defmodule GradelyWeb.URIHelpers do

  def uri_add_params(conn, params) do
    "?" <> (Map.merge(conn, params) |> URI.encode_query)
  end

  def uri_params_equal?(a, b) do
    a = if String.contains?(a, "?"), do: String.replace(a, "?", ""), else: a
    b = if String.contains?(b, "?"), do: String.replace(b, "?", ""), else: b
    URI.decode_query(a) == URI.decode_query(b)
  end
end