defmodule Seeds do
  alias Pow.Ecto.Schema.Password

  @organizations [
    %{name: "School Place"},
    %{name: "University One"}
  ]

  @users [
    %{email: "a", password: "a", type: 0},
    %{email: "b", password: "b", type: 1}
  ]

  @students_num 60
  @courses_num 18
  @activities_num 3
  @activity_types ["Quiz", "Exam", "Reading", "Assignment"]

  def create_organization(organization) do
    %Gradely.Organizations.Organization{
      name: organization.name
    }
    |> Ecto.Changeset.change
    |> Gradely.Repo.insert!
  end

  def create_user(user, organization) do
    %Gradely.Users.User{
      email: user.email,
      password_hash: Password.pbkdf2_hash(user.password),
      type: user.type
    }
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:organization, organization)
    |> Gradely.Repo.insert!
  end

  def create_student(organization) do
    {:ok, student} = Gradely.Students.create(
      %{
        student: %{
          first_name: Faker.Name.first_name,
          last_name: Faker.Name.last_name
        },
        organization: organization
      }
    )

    student
  end

  def create_course(organization) do
    {:ok, course} = Gradely.Courses.create(
      %{
        course: %{
          name: Enum.join([Faker.Industry.industry, Integer.to_string(Enum.random(101..500))], " ")
        },
        organization: organization
      }
    )

    course
  end

  def create_activity(course, user) do
    {:ok, activity} = Gradely.Activities.create(
      %{
        activity: %{
          name: "#{Faker.Superhero.name} #{}",
          total_value: Enum.random(60..100),
          weight: Enum.random(10..40)
        },
        course: course,
        user: user,
      }
    )

    activity
  end

  def add_courses_to_student(student, courses) do
    courses = Enum.take_random(courses, Enum.random(1..div(@courses_num, 2)))
    Gradely.Students.add_courses(student ,courses)
  end

  def add_course_to_student(student, courses) do
    courses = Enum.take_random(courses, Enum.random(1..div(@courses_num, 2)))
    Gradely.Students.add_courses(student ,courses)
  end

  def create_activities_for_course(course, user) do
    course = Gradely.Repo.preload(course, :activities)
    course

    Enum.each(0..@activities_num, fn _ -> create_activity(course, user) end)
  end

  def run do
    organizations = Enum.map(@organizations, &create_organization/1)
    users = Enum.map(@users, fn u -> create_user(u, Enum.at(organizations, 0)) end)
    # students = Enum.map(0..@students_num, fn _ -> create_student(Enum.at(organizations, 0)) |> Gradely.Repo.preload(:courses) end)
    # courses = Enum.map(0..@courses_num, fn _ -> create_course(Enum.at(organizations, 0)) end)

    # Enum.each(students, fn student -> add_courses_to_student(student, courses) end)

    # Enum.each(courses, fn course -> create_activities_for_course(course, Enum.at(users, 0)) end)


    # activities = Enum.map(0..@activities_num,
    #   fn _ -> create_activity(
    #     Enum.at(courses, 0),
    #     Enum.at(users, 0)
    #   )
    #   end
    # )

  end

  def run_test do
    organizations = Enum.map(@organizations, &create_organization/1)
    Enum.each(@users, fn u -> create_user(u, Enum.at(organizations, 0)) end)
  end
end


case Mix.env do
  :dev 	-> Seeds.run
  :test -> Seeds.run_test
end

