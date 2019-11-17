defmodule GradelyWeb.Components do

  def c(template, assigns) do
    GradelyWeb.ComponentView.render(template, assigns)
  end

  def c(template, assigns, do: block) do
    GradelyWeb.ComponentView.render(template, Keyword.merge(assigns, [do: block]))
  end
end

