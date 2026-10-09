defmodule GradeAnalyzerWebWeb.Router do
  use GradeAnalyzerWebWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {GradeAnalyzerWebWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GradeAnalyzerWebWeb do
    pipe_through :browser

    get "/", PageController, :home
    post "/analyze", PageController, :analyze
    get "/students", PageController, :students
    get "/class-analysis", PageController, :class_analysis
    post "/students", PageController, :create_student
    get "/students/:id/edit", PageController, :edit_student
    put "/students/:id", PageController, :update_student
    delete "/students/:id", PageController, :delete_student
  end

  # Other scopes may use custom stacks.
  # scope "/api", GradeAnalyzerWebWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:grade_analyzer_web, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: GradeAnalyzerWebWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
