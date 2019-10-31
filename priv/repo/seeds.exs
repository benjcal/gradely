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

user = %Gradely.Users.User{
    email: "aa@bb.cc",
    password_hash: Password.pbkdf2_hash "qwerty" }
 |> Ecto.Changeset.change
 |> Gradely.Repo.insert!

student = Gradely.Students.create_student %{first_name: "Ben", last_name: "Cal", user_id: user.id}
course = Gradely.Courses.create_course %{name: "Course", user_id: user.id}