defmodule GradeAnalyzer do
  @students [
    %{name: "Ali", marks: 85},
    %{name: "Sara", marks: 72},
    %{name: "John", marks: 91},
    %{name: "Ayesha", marks: 64},
    %{name: "Sana", marks: 42},
    %{name: "David", marks: 48}
  ]

  def students do
    @students
  end

  def average_marks([]), do: 0.0

  def average_marks(students) do
    total =
      Enum.reduce(students, 0, fn student, acc ->
        acc + student.marks
      end)

    total / length(students)
  end

  def highest_scorer([]), do: nil

  def highest_scorer(students) do
    Enum.max_by(students, & &1.marks)
  end

  def lowest_scorer([]), do: nil

  def lowest_scorer(students) do
    Enum.min_by(students, & &1.marks)
  end

  def count_passed(students) do
    Enum.count(students, fn student ->
      student.marks >= 50
    end)
  end

  def count_failed(students) do
    Enum.count(students, fn student ->
      student.marks < 50
    end)
  end

  def grade(marks) when marks >= 90, do: :A
  def grade(marks) when marks >= 80, do: :B
  def grade(marks) when marks >= 70, do: :C
  def grade(marks) when marks >= 60, do: :D
  def grade(_marks), do: :F

  def all_students_with_grades(students) do
    Enum.map(students, fn student ->
      Map.put(student, :grade, grade(student.marks))
    end)
  end

  def count_by_grade(students) do
    counts =
      students
      |> Enum.map(fn student -> grade(student.marks) end)
      |> Enum.frequencies()

    Map.merge(%{A: 0, B: 0, C: 0, D: 0, F: 0}, counts)
  end

  def analyze(students) do
    %{
      total_students: length(students),
      average: average_marks(students),
      highest: highest_scorer(students),
      lowest: lowest_scorer(students),
      passed: count_passed(students),
      failed: count_failed(students),
      students_with_grades: all_students_with_grades(students),
      grade_distribution: count_by_grade(students)
    }
  end
end
