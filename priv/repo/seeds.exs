# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Gradely.Repo.insert!(%Gradely.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Pow.Ecto.Schema.Password

users = [
  %{email: "aa@gradely.io", password: "qwerty"},
  %{email: "bb@gradely.io", password: "qwerty"},
  %{email: "cc@gradely.io", password: "qwerty"}
]

students = [
	%{first_name: "Ben", last_name: "Cal"},
	%{first_name: "Ben", last_name: "Cal"},
	%{first_name: "Ben", last_name: "Cal"},
	%{first_name: "Ben", last_name: "Cal"},
	%{first_name: "Ben", last_name: "Cal"},
	%{first_name: "Ben", last_name: "Cal"},
]

courses = [
	%{name: "Course 1"},
	%{name: "Course 2"},
	%{name: "Course 3"},
	%{name: "Course 4"},
]

create_user = fn user ->
  %Gradely.Users.User{
    email: user.email,
    password_hash: Password.pbkdf2_hash(user.password)
  }
	|> Ecto.Changeset.change
 	|> Gradely.Repo.insert!
end

users = Enum.map(users, create_user)

create_student = fn student -> 
	{:ok, student} = Gradely.Students.create_student Map.put(student, :user, Enum.at(users, 0))
	student
end

create_course = fn course -> 
	{:ok, course} = Gradely.Courses.create_course Map.put(course, :user, Enum.at(users, 0))
	course
end

enroll_student = fn (student, courses) -> 
	Gradely.Enrollments.enroll_student(student, courses)	
end

students =  Enum.map(students, create_student)
courses =  Enum.map(courses, create_course)


Enum.each(students, fn student -> enroll_student.(student, courses) end)