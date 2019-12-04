defmodule Gradely.Students do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  import Gradely.Utils
  alias Gradely.Repo
  alias Gradely.Students.Student
  alias Gradely.Users

  def get_table_page(user, params) do
    user = user
           |> Repo.preload(:organization)


    sort = case params["sort"] do
      "name" -> :first_name
      _ -> :id
    end

    # TODO
    # admin get students from all organization
    # if educator get student from courses they are assigned to

    case Users.is_admin(user) do
      true -> Student
      |> order_by(asc: ^sort)
      |> where([s], s.organization_id == ^user.organization.id)
      |> preload(:courses)
      #|> preload([courses: :activities])
      #|> preload([courses: [activities: :grade]])
      |> Repo.paginate(params)
      false -> nil
    end



    # Users.update_preferences(conn.assigns.current_user, %{student_table_sort: "name"})

  end

  def get_student!(id) do
    Repo.get!(Student, id)
    |> Repo.preload(:courses)
    |> Repo.preload([courses: :activities])
    |> Repo.preload([courses: [activities: :grade]])
  end

  def get_student_clean!(id), do: Repo.get!(Student, id)

  def by_user(user_id) when is_integer(user_id) do
    Student
    |> where([s], s.user_id == ^user_id)
    |> Repo.all
    |> Repo.preload(:courses)
    |> Repo.preload([courses: :activities])
    |> Repo.preload([courses: [activities: :grade]])
  end

  def create(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs[:student])
    |> put_assoc(:organization, attrs[:organization])
    #|> maybe_put_assoc(:courses, attrs[:courses])
    |> Repo.insert()
    |> IO.inspect
  end





  def update(attrs \\ %{}) do
    attrs[:student]
    |> Student.changeset(attrs[:updates])
    |> put_assoc(:courses, attrs[:courses])
    |> Repo.update()
  end

  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  def change_student(%Student{} = student) do
    Student.changeset(student, %{})
  end
end
