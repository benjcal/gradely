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
	%{email: "a", password: "a"},
	%{email: "b", password: "b"},
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

create_student = fn num ->
	{:ok, student} = Gradely.Students.create_student %{first_name: Faker.Name.first_name, last_name: Faker.Name.last_name, number: Integer.to_string(num), user: Enum.at(users, Enum.random(0..1))}
	student
end

create_course = fn _  ->
	{:ok, course} =
		Gradely.Courses.create_course %{name: Enum.join([Faker.Industry.industry, Integer.to_string(Enum.random(101..500))], " "), user: Enum.at(users, Enum.random(0..1))}
	course
end

enroll_student = fn (student, courses) ->
	Gradely.Enrollments.enroll_student(student, courses)
end

students =  Enum.map(1001..1056, create_student)
courses =  Enum.map(0..34, create_course)


Enum.each(students, fn student -> enroll_student.(student, courses) end)