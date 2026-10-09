defmodule GradeAnalyzerWebWeb.PageControllerTest do
  use GradeAnalyzerWebWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Grade Analyzer"
  end
end
