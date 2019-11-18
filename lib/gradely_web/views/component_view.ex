defmodule GradelyWeb.ComponentView do
  use GradelyWeb, :view

  def button_classes do
    "h-8 w-24 flex items-center justify-center shadow rounded border border-transparent hover:border-gray-400 text-gray-400 font-bold hover:text-gray-700"
  end
end
