defmodule GradelyWeb.Styles do
  @button_class "dib w4 h2 br2 flex items-center justify-center link pointer bw0 "

  def button_class do
    @button_class <> " bg-blue white"
  end

  def button_class(color) do
    case color do
      :red -> @button_class <> "bg-red white"
      :green -> @button_class <> "bg-green white"
      :gray -> @button_class <> "bg-gray white"
      _ -> @button_class <> "bg-blue white"
    end
  end

  def label_class do
    "f6 fw6 brand-accent"
  end

  def container_class do
    "mh4 mv3 ph4 pv3 br2 bg-white"
  end

  def container_header_class do
    "flex bb b--black-10 items-center brand-dark"
  end
end
