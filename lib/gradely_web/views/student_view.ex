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

  def activities_all(courses) do
    courses
    |> Enum.map(fn c -> c.activities end)
    |> List.flatten
  end

  def activities_graded(courses) do
    activities_all(courses)
    |> Enum.filter(fn a -> a.grade != nil end)
  end

  def average_grade(courses) do
    activities = activities_graded(courses)
    total = activities
    |> Enum.map(fn a -> (a.grade.value/a.total_value) * 100 end)
    |> Enum.sum

    0

  end


end
