defmodule EventsWeb.Router do
  use EventsWeb, :router

  import EventsWeb.UsersAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {EventsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_users
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EventsWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", EventsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: EventsWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", EventsWeb do
    pipe_through [:browser, :redirect_if_users_is_authenticated]

    get "/users/register", UsersRegistrationController, :new
    post "/users/register", UsersRegistrationController, :create
    get "/users/log_in", UsersSessionController, :new
    post "/users/log_in", UsersSessionController, :create
    get "/users/reset_password", UsersResetPasswordController, :new
    post "/users/reset_password", UsersResetPasswordController, :create
    get "/users/reset_password/:token", UsersResetPasswordController, :edit
    put "/users/reset_password/:token", UsersResetPasswordController, :update
  end

  scope "/", EventsWeb do
    pipe_through [:browser, :require_authenticated_users]

    live "/eventslists", EventListLive.Index, :index
    live "/eventslists/new", EventListLive.Index, :new
    live "/eventslists/:id/edit", EventListLive.Index, :edit

    live "/eventslists/:id", EventListLive.Show, :show
    live "/eventslists/:id/show/edit", EventListLive.Show, :edit

    live "/customers", CustomerLive.Index, :index
    live "/customers/new", CustomerLive.Index, :new
    live "/customers/:id/edit", CustomerLive.Index, :edit

    live "/customers/:id", CustomerLive.Show, :show
    live "/customers/:id/show/edit", CustomerLive.Show, :edit

    live "/events_descriptions", EventDescriptionLive.Index, :index
    live "/events_descriptions/new", EventDescriptionLive.Index, :new
    live "/events_descriptions/:id/edit", EventDescriptionLive.Index, :edit

    live "/events_descriptions/:id", EventDescriptionLive.Show, :show
    live "/events_descriptions/:id/show/edit", EventDescriptionLive.Show, :edit

    live "/notifications", NotificationLive.Index, :index
    live "/notifications/new", NotificationLive.Index, :new
    live "/notifications/:id/edit", NotificationLive.Index, :edit

    live "/notifications/:id", NotificationLive.Show, :show
    live "/notifications/:id/show/edit", NotificationLive.Show, :edit

    live "/tickets", TicketLive.Index, :index
    live "/tickets/new", TicketLive.Index, :new
    live "/tickets/:id/edit", TicketLive.Index, :edit

    live "/tickets/:id", TicketLive.Show, :show
    live "/tickets/:id/show/edit", TicketLive.Show, :edit


    live "/scans", ScanLive.Index, :index
    live "/scans/new", ScanLive.Index, :new
    live "/scans/:id/edit", ScanLive.Index, :edit

    live "/scans/:id", ScanLive.Show, :show
    live "/scans/:id/show/edit", ScanLive.Show, :edit

    get "/users/settings", UsersSettingsController, :edit
    put "/users/settings", UsersSettingsController, :update
    get "/users/settings/confirm_email/:token", UsersSettingsController, :confirm_email
  end

  scope "/", EventsWeb do
    pipe_through [:browser]

    delete "/users/log_out", UsersSessionController, :delete
    get "/users/confirm", UsersConfirmationController, :new
    post "/users/confirm", UsersConfirmationController, :create
    get "/users/confirm/:token", UsersConfirmationController, :edit
    post "/users/confirm/:token", UsersConfirmationController, :update
  end
end
