defmodule GradelyWeb.Router do
  use GradelyWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", GradelyWeb do
    pipe_through [:browser, :protected]

    get "/", PageController, :index

    get "/search", GlobalSearchController, :search

    resources "/courses", CourseController do
      resources "/activities", ActivityController
    end

    resources "/grades", GradeController
    resources "/students", StudentController
    resources "/tracks", TrackController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GradelyWeb do
  #   pipe_through :api
  # end
end
