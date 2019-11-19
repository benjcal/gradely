defmodule GradelyWeb.StudentView do
  use GradelyWeb, :view

  def is_enrolled(course, enrolled_courses) do
    Enum.find_value(enrolled_courses, fn c -> c.id == course.id end)
  end

  def color(x) do
    AlchemicAvatar.Color.iwanthue(x)
    |> Enum.map(fn c -> Integer.to_string(c, 16) end )
    |> Enum.join("")
  end

  def all_activities(courses) do
    courses
    |> Enum.map(fn c -> c.activities end)
    |> List.flatten
  end
end
