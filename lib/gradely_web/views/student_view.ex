defmodule GradelyWeb.StudentView do
  use GradelyWeb, :view

  def is_enrolled(course, enrolled_courses) do
    Enum.find_value(enrolled_courses, fn c -> c.id == course.id end)
  end

  def color(x) do
    AlchemicAvatar.Color.google(x)
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
  end

  def grade_id(student, activity) do
    student_id = Integer.to_string(student.id)
    activity_id = Integer.to_string(activity.id)

    "grade_" <> student_id <> "_" <> activity_id
  end

  def grade_id_late(student, activity) do
    grade_id(student, activity) <> "_late"
  end

  def grade_id_missing(student, activity) do
    grade_id(student, activity) <> "_missing"
  end

  def gen_chart_data() do
    a = %{
      type: "bar",
      data: %{
        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        datasets: [
          %{
            label: "# of Votes",
            data: [12, 19, 3, 5, 2, 3]
          }
        ]
      },
      options: %{
        legend: %{ display: false },
        scales: %{
          xAxes: [%{ display: false }],
          yAxes: [%{ display: false }]
        }
      }
    }
    
    Jason.encode! a
  end

end
