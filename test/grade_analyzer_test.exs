defmodule GradeAnalyzerTest do
  use ExUnit.Case

  @students [
    %{name: "Ali", marks: 85},
    %{name: "Sara", marks: 72},
    %{name: "John", marks: 91},
    %{name: "Ayesha", marks: 64},
    %{name: "David", marks: 48}
  ]

  # Tests for average_marks/1
  test "calculates average marks" do
    assert GradeAnalyzer.average_marks(@students) == 72.0
  end

  test "average marks returns zero for an empty list" do
    assert GradeAnalyzer.average_marks([]) == 0.0
  end

  test "calculates average for one student" do
    students = [%{name: "Ali", marks: 80}]
    assert GradeAnalyzer.average_marks(students) == 80.0
  end

  # Tests for highest_scorer/1
  test "returns the student with the highest marks" do
    assert GradeAnalyzer.highest_scorer(@students) == %{name: "John", marks: 91}
  end

  test "highest scorer returns nil for an empty list" do
    assert GradeAnalyzer.highest_scorer([]) == nil
  end

  test "highest scorer handles a list with one student" do
    student = %{name: "Sara", marks: 75}
    assert GradeAnalyzer.highest_scorer([student]) == student
  end

  # Tests for lowest_scorer/1
  test "returns the student with the lowest marks" do
    assert GradeAnalyzer.lowest_scorer(@students) == %{name: "David", marks: 48}
  end

  test "lowest scorer returns nil for an empty list" do
    assert GradeAnalyzer.lowest_scorer([]) == nil
  end

  test "lowest scorer handles a list with one student" do
    student = %{name: "Sara", marks: 75}
    assert GradeAnalyzer.lowest_scorer([student]) == student
  end

  # Tests for count_passed/1
  test "counts students who passed" do
    assert GradeAnalyzer.count_passed(@students) == 4
  end

  test "returns zero when no students passed" do
    students = [
      %{name: "Ali", marks: 30},
      %{name: "Sara", marks: 45}
    ]

    assert GradeAnalyzer.count_passed(students) == 0
  end

  test "counts a student who scored exactly 50" do
    students = [%{name: "Ali", marks: 50}]
    assert GradeAnalyzer.count_passed(students) == 1
  end

  # Tests for count_failed/1
  test "counts students who failed" do
    assert GradeAnalyzer.count_failed(@students) == 1
  end

  test "returns zero when no students failed" do
    students = [
      %{name: "Ali", marks: 70},
      %{name: "Sara", marks: 85}
    ]

    assert GradeAnalyzer.count_failed(students) == 0
  end

  test "counts a student who scored below 50" do
    students = [%{name: "David", marks: 49}]
    assert GradeAnalyzer.count_failed(students) == 1
  end

  # Tests for grade/1
  test "assigns grade A for marks of 90 or above" do
    assert GradeAnalyzer.grade(95) == :A
  end

  test "assigns grade C for marks between 70 and 79" do
    assert GradeAnalyzer.grade(75) == :C
  end

  test "assigns grade F for marks below 60" do
    assert GradeAnalyzer.grade(55) == :F
  end

  # Tests for all_students_with_grades/1
  test "adds grades to all students" do
    result = GradeAnalyzer.all_students_with_grades(@students)
    assert Enum.at(result, 0) == %{name: "Ali", marks: 85, grade: :B}
    assert Enum.at(result, 2) == %{name: "John", marks: 91, grade: :A}
  end

  test "returns an empty list when there are no students" do
    assert GradeAnalyzer.all_students_with_grades([]) == []
  end

  test "adds a grade to a single student" do
    students = [%{name: "Sara", marks: 75}]

    assert GradeAnalyzer.all_students_with_grades(students) == [
             %{name: "Sara", marks: 75, grade: :C}
           ]
  end

  # Tests for count_by_grade/1
  test "counts students in each grade category" do
    assert GradeAnalyzer.count_by_grade(@students) == %{A: 1, B: 1, C: 1, D: 1, F: 1}
  end

  test "returns zero counts for an empty student list" do
    assert GradeAnalyzer.count_by_grade([]) == %{A: 0, B: 0, C: 0, D: 0, F: 0}
  end

  test "includes zero for grade categories with no students" do
    students = [
      %{name: "Ali", marks: 95},
      %{name: "Sara", marks: 92}
    ]

    assert GradeAnalyzer.count_by_grade(students) == %{A: 2, B: 0, C: 0, D: 0, F: 0}
  end

  # Tests for analyze/1
  test "generates a complete student analysis report" do
    result = GradeAnalyzer.analyze(@students)

    assert result.average == 72.0
    assert result.highest == %{name: "John", marks: 91}
    assert result.lowest == %{name: "David", marks: 48}
    assert result.passed == 4
    assert result.failed == 1
    assert result.grade_distribution == %{A: 1, B: 1, C: 1, D: 1, F: 1}
  end

  test "generates a report for an empty student list" do
    result = GradeAnalyzer.analyze([])

    assert result.average == 0.0
    assert result.highest == nil
    assert result.lowest == nil
    assert result.passed == 0
    assert result.failed == 0
    assert result.students_with_grades == []
    assert result.grade_distribution == %{A: 0, B: 0, C: 0, D: 0, F: 0}
  end

  test "analyzes a list containing one student" do
    students = [%{name: "Sara", marks: 85}]
    result = GradeAnalyzer.analyze(students)

    assert result.average == 85.0
    assert result.highest == hd(students)
    assert result.lowest == hd(students)
    assert result.passed == 1
    assert result.failed == 0
  end
end
