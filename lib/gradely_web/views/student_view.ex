defmodule GradelyWeb.StudentView do
  use GradelyWeb, :view

  def is_enrolled(course, enrolled_courses) do
    Enum.find_value(enrolled_courses, fn c -> c.id == course.id end)
  end
end
