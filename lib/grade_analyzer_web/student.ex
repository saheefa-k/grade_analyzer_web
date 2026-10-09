defmodule GradeAnalyzerWeb.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :name, :string
    field :marks_obtained, :float
    field :total_marks, :float
    timestamps(type: :utc_datetime)
  end

  def changeset(student, attrs) do
    changeset =
      student
      |> cast(attrs, [:name, :marks_obtained, :total_marks])
      |> validate_required([:name, :marks_obtained, :total_marks])
      |> validate_number(:marks_obtained, greater_than_or_equal_to: 0)
      |> validate_number(:total_marks, greater_than: 0)

    validate_change(changeset, :marks_obtained, fn :marks_obtained, marks ->
      total = get_field(changeset, :total_marks)

      if total && marks > total do
        [marks_obtained: "cannot exceed total marks"]
      else
        []
      end
    end)
  end
end
