defmodule GradelyWeb.Components do

  def c(template, assigns) do
    template = Atom.to_string(template) <> ".html"
    GradelyWeb.ComponentView.render(template, assigns)
  end

  def c(template, assigns, do: block) do
    template = Atom.to_string(template) <> ".html"
    GradelyWeb.ComponentView.render(template, Map.merge(assigns, %{content: block}))
  end
end

