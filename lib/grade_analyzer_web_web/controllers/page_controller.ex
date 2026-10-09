defmodule GradeAnalyzerWebWeb.PageController do
  use GradeAnalyzerWebWeb, :controller
  alias GradeAnalyzer
  alias GradeAnalyzerWeb.Students

  def home(conn, _params) do
    {students, analysis} = dashboard_data()

    render(conn, :home,
      result: nil,
      error: nil,
      students: students,
      analysis: analysis
    )
  end

  def analyze(conn, params) do
    student_name = Map.get(params, "student_name", "")
    marks_text = Map.get(params, "marks_obtained", "")
    total_text = Map.get(params, "total_marks", "")
    {_students, analysis} = dashboard_data()

    with {marks, ""} <- Float.parse(marks_text),
         {total, ""} <- Float.parse(total_text),
         true <- total > 0,
         true <- marks >= 0 and marks <= total do
      percentage = marks / total * 100
      grade = GradeAnalyzer.grade(percentage)
      result = %{student_name: student_name, percentage: Float.round(percentage, 2), grade: grade}

      render(conn, :home,
        result: result,
        error: nil,
        students: analysis.students_with_grades,
        analysis: analysis
      )
    else
      _ ->
        render(conn, :home,
          result: nil,
          error:
            "Please enter valid marks. Total marks must be greater than zero, and obtained marks must be between zero and total marks.",
          students: analysis.students_with_grades,
          analysis: analysis
        )
    end
  end

  def students(conn, _params) do
    students =
      Students.list_students()
      |> Enum.map(fn student ->
        percentage = student.marks_obtained / student.total_marks * 100

        %{
          id: student.id,
          name: student.name,
          marks_obtained: student.marks_obtained,
          total_marks: student.total_marks,
          percentage: Float.round(percentage, 2),
          grade: GradeAnalyzer.grade(percentage)
        }
      end)

    render(conn, :students, students: students)
  end

  def create_student(conn, params) do
    case Students.create_student(params) do
      {:ok, _student} ->
        conn
        |> put_flash(:info, "Student added successfully!")
        |> redirect(to: ~p"/students")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Invalid student details. Check the marks and try again.")
        |> redirect(to: ~p"/students")
    end
  end

  def class_analysis(conn, _params) do
    students = Students.list_students()

    analysis_students =
      Enum.map(students, fn student ->
        %{name: student.name, marks: student.marks_obtained / student.total_marks * 100}
      end)

    analysis =
      analysis_students |> GradeAnalyzer.analyze() |> Map.put(:total_students, length(students))

    render(conn, :class_analysis, analysis: analysis)
  end

  def edit_student(conn, %{"id" => id}) do
    student = Students.get_student!(id)
    changeset = GradeAnalyzerWeb.Student.changeset(student, %{})
    render(conn, :edit_student, student: student, changeset: changeset)
  end

  def update_student(conn, %{"id" => id} = params) do
    student = Students.get_student!(id)

    case Students.update_student(student, params) do
      {:ok, _student} ->
        conn
        |> put_flash(:info, "Student updated successfully!")
        |> redirect(to: ~p"/students")

      {:error, changeset} ->
        render(conn, :edit_student, student: student, changeset: changeset)
    end
  end

  def delete_student(conn, %{"id" => id}) do
    student = Students.get_student!(id)

    case Students.delete_student(student) do
      {:ok, _student} ->
        conn
        |> put_flash(:info, "Student deleted successfully!")
        |> redirect(to: ~p"/students")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Could not delete student.")
        |> redirect(to: ~p"/students")
    end
  end

  defp dashboard_data do
    db_students = Students.list_students()

    analysis_students =
      Enum.map(db_students, fn student ->
        %{name: student.name, marks: student.marks_obtained / student.total_marks * 100}
      end)

    students = GradeAnalyzer.all_students_with_grades(analysis_students)
    total = length(students)
    passed = Enum.count(students, &(&1.marks >= 50))

    grade_distribution =
      Enum.reduce([:A, :B, :C, :D, :F], %{}, fn grade, acc ->
        Map.put(acc, grade, Enum.count(students, &(&1.grade == grade)))
      end)

    top_performers = Enum.sort_by(students, & &1.marks, :desc) |> Enum.take(3)
    pass_rate = if total > 0, do: Float.round(passed / total * 100, 2), else: 0.0

    analysis =
      analysis_students
      |> GradeAnalyzer.analyze()
      |> Map.put(:total_students, total)
      |> Map.put(:passed, passed)
      |> Map.put(:failed, total - passed)
      |> Map.put(:grade_distribution, grade_distribution)
      |> Map.put(:top_performers, top_performers)
      |> Map.put(:pass_rate, pass_rate)
      |> Map.put(:grade_chart_max, max(Enum.max(Map.values(grade_distribution), fn -> 0 end), 1))

    {students, analysis}
  end
end
