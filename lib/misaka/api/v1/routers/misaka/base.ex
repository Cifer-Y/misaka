defmodule Router.Misaka.Base.V1 do
  use Maru.Router
  import Helpers.Utils.V1

  prefix :base

  resources :first do
    desc "desc"
    params do
      requires :arg, type: String
    end
    get do
      json(conn, params[:arg])
    end
  end
end
