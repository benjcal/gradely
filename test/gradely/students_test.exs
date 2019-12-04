defmodule Gradely.StudentsTest do
  use Gradely.DataCase

  alias Gradely.Students

  describe "students" do
    alias Gradely.Students.Student
    alias Gradely.Users
    alias Gradely.Organizations

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name"}
    @invalid_attrs %{first_name: nil, last_name: nil}

    def student_fixture(attrs \\ %{}) do
      organization = Organizations.get_organization!(1)

      {:ok, student} = Students.create(
          %{
              organization: organization,
              student: %{
                first_name: "some first name",
                last_name: "some last name"
              }
          }
      )

      student
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Students.get_student!(student.id) == student
    end

    # test "create_student/1 with valid data creates a student" do
    #   assert {:ok, %Student{} = student} = Students.create_student(@valid_attrs)
    #   assert student.first_name == "some first_name"
    #   assert student.last_name == "some last_name"
    # end

    # test "create_student/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Students.create_student(@invalid_attrs)
    # end

    # test "update_student/2 with valid data updates the student" do
    #   student = student_fixture()
    #   assert {:ok, %Student{} = student} = Students.update_student(student, @update_attrs)
    #   assert student.first_name == "some updated first_name"
    #   assert student.last_name == "some updated last_name"
    # end

    # test "update_student/2 with invalid data returns error changeset" do
    #   student = student_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Students.update_student(student, @invalid_attrs)
    #   assert student == Students.get_student!(student.id)
    # end

    # test "delete_student/1 deletes the student" do
    #   student = student_fixture()
    #   assert {:ok, %Student{}} = Students.delete_student(student)
    #   assert_raise Ecto.NoResultsError, fn -> Students.get_student!(student.id) end
    # end

    # test "change_student/1 returns a student changeset" do
    #   student = student_fixture()
    #   assert %Ecto.Changeset{} = Students.change_student(student)
    # end

  end
end
