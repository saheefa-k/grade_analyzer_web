defmodule GradeAnalyzerWeb.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string
      add :marks_obtained, :float
      add :total_marks, :float

      timestamps(type: :utc_datetime)
    end
  end
end
