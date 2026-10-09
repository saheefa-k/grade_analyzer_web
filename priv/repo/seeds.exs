# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GradeAnalyzerWeb.Repo.insert!(%GradeAnalyzerWeb.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias GradeAnalyzerWeb.Repo
alias GradeAnalyzerWeb.Student

if Repo.aggregate(Student, :count, :id) == 0 do
  for %{name: name, marks: marks} <- GradeAnalyzer.students() do
    Repo.insert!(%Student{
      name: name,
      marks_obtained: marks * 1.0,
      total_marks: 100.0
    })
  end
end
