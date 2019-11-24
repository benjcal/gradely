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
defmodule Seeds do
	alias Pow.Ecto.Schema.Password

	@users [
		%{email: "a", password: "a"},
		%{email: "b", password: "b"}
	]

	@students_num 60
	@courses_num 8

	def create_user(user) do
		%Gradely.Users.User{
			email: user.email,
			password_hash: Password.pbkdf2_hash(user.password)
		}
		|> Ecto.Changeset.change
		|> Gradely.Repo.insert!
	end

	def create_student(users) do
		{:ok, student} = Gradely.Students.create(
			%{
				student: %{
					first_name: Faker.Name.first_name,
					last_name: Faker.Name.last_name
				},
				user: Enum.at(users, Enum.random(0..(length(@users) -1)))
			}
		)

		student
	end

	def create_course(users) do
		{:ok, course} = Gradely.Courses.create_course(%{
			name: Enum.join([Faker.Industry.industry, Integer.to_string(Enum.random(101..500))], " "),
			user: Enum.at(users, Enum.random(0..(length(@users) -1)))})
		course
	end

	def enroll_student(student, courses) do
		courses = Enum.take_random(courses, Enum.random(1..div(@courses_num, 2)))
		Gradely.Enrollments.enroll_student(student, courses)
	end

	def run do
		users = Enum.map(@users, &create_user/1)
		students = Enum.map(0..@students_num, fn _ -> create_student(users) end)
		# courses = Enum.map(0..@courses_num, fn _ -> create_course(users) end)
		# Enum.each(students, fn student -> enroll_student(student, courses) end)
	end

	def run_test do
		Enum.map(@users, &create_user/1)
	end
end

IO.inspect Mix.env

case Mix.env do
	:dev 	-> Seeds.run
	:test -> Seeds.run_test
end


