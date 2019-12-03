defmodule Seeds do
	alias Pow.Ecto.Schema.Password

	@organizations [
		%{name: "School Place"},
		%{name: "Univrsity One"}
	]

	@users [
		%{email: "a", password: "a"},
		%{email: "b", password: "b"}
	]

	# @students_num 60
	@courses_num 18
	# @activities_num 80

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
			password_hash: Password.pbkdf2_hash(user.password)
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
		|> Gradely.Repo.preload(:courses)
	end

	def create_course(users) do
		{:ok, course} = Gradely.Courses.create(
			%{
				course: %{
					name: Enum.join([Faker.Industry.industry, Integer.to_string(Enum.random(101..500))], " ")
				},
				user: Enum.at(users, Enum.random(0..(length(@users) -1)))
			}
		)

		course
		|> Gradely.Repo.preload(:activities)
	end

	def create_activity(users, courses) do
		{:ok, activity} = Gradely.Activities.create(
			%{
				activity: %{
					name: Faker.StarWars.planet,
					total_value: Enum.random(60..100),
					weight: Enum.random(10..40)
				},
				course: List.first(Enum.take_random(courses, 1)),
				user: List.first(Enum.take_random(users, 1))
			}
		)

		activity
	end

	def enroll_student(student, courses) do
		courses = Enum.take_random(courses, Enum.random(1..div(@courses_num, 2)))
		Gradely.Enrollments.enroll_student(student, courses)
	end

	def run do
		# organizations = Enum.map(@organizations, &create_organization/1)
		# users = Enum.map(@users, &create_user/1)
		# students = Enum.map(0..@students_num, fn _ -> create_student(users) end)
		# courses = Enum.map(0..@courses_num, fn _ -> create_course(users) end)

		# Enum.each(students, fn student -> enroll_student(student, courses) end)

		# activities = Enum.map(0..@activities_num, fn _ -> create_activity(users, courses) end)
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


