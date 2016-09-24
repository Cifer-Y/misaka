defmodule Routers.V1 do
  use Maru.Router

  version "v1"


  # plugs here
  plug Middleware.Auth.Free.V1
  # plug_overridable :session_fetcher, Middleware.Session.Fetcher.V1
  # plug_overridable :session_updater, Middleware.Session.Updater.V1
  # plug_overridable :suspend, Middleware.Auth.Suspend.V1
  # plug_overridable :auth, Middleware.Auth.Admin.V1

  # mounts here
  mount Router.Misaka.V1


end
