defmodule GradelyWeb.ComponentsHelper do


  def component(component) do
    GradelyWeb.ComponentView.render(Atom.to_string(component) <> ".html")
  end
end