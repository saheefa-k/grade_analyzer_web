Grade Analyzer 🎓

A web-based student grade analysis system built with Elixir, Phoenix Framework, and PostgreSQL. The application helps users calculate individual student grades, manage student records, and review class performance through an interactive dashboard.

✨ Features
Dashboard: View total students, class average, passed students, and failed students.
Student Assessment: Calculate a student's percentage, grade, and pass/fail status.
Student Management: Add, view, edit, and delete student records.
Class Analysis: Review class performance and detailed statistics.
Grade Distribution: View how students are distributed across grade categories.
Top Performers: Identify the highest-performing students.
Pass Rate: Monitor the percentage of students who pass.
Database Integration: Store student records in PostgreSQL.
Responsive UI: Navigate the application through a clean, responsive interface.
🛠️ Technologies Used
Language: Elixir
Web Framework: Phoenix Framework
Database: PostgreSQL
Database Integration: Ecto
Frontend: HEEx, HTML, Tailwind CSS, daisyUI
Version Control: Git and GitHub
📊 Grade Scale
Grade	Percentage
A	90–100%
B	80–89%
C	70–79%
D	60–69%
F	Below 60%

Passing criteria: A student passes with a percentage of 50% or above.

⚙️ Prerequisites

Before running the application, install:

Elixir and Erlang/OTP
PostgreSQL
Git
🚀 Installation and Setup
1. Clone the repository
git clone YOUR_GITHUB_REPOSITORY_URL
cd grade_analyzer_web

Replace YOUR_GITHUB_REPOSITORY_URL with your actual repository URL.

2. Install dependencies
mix deps.get
3. Configure the database

Check config/dev.exs and ensure the PostgreSQL username, password, hostname, and database settings match your local PostgreSQL configuration.

Do not commit real database passwords or other secrets to GitHub.

4. Create the database
mix ecto.create
5. Run database migrations
mix ecto.migrate
6. Start the Phoenix server
mix phx.server

Open your browser and visit:

http://localhost:4000

🧪 Run Tests

Execute the test suite using:

mix test
📁 Project Structure
grade_analyzer_web/
├── config/
├── lib/
│   ├── grade_analyzer_web/
│   │   ├── grade_analyzer.ex
│   │   ├── student.ex
│   │   ├── students.ex
│   │   └── repo.ex
│   └── grade_analyzer_web_web/
│       ├── controllers/
│       ├── components/
│       └── router.ex
├── priv/
│   └── repo/
│       └── migrations/
├── test/
├── mix.exs
└── README.md
🎯 Project Objective

The objective of Grade Analyzer is to simplify student grade calculation and class performance monitoring through a web application with database-backed student management and analytical features.

👩‍💻 Development

This project was developed using Elixir and Phoenix, with PostgreSQL for persistent storage and HEEx/Tailwind CSS for the user interface.

📄 License

Add a license if you intend to distribute this project for reuse. Until then, no license is specified