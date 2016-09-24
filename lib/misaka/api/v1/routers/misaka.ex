defmodule Router.Misaka.V1 do
  use Maru.Router

  prefix :api_root

  # mount children here
  mount Router.Misaka.Base.V1
end
