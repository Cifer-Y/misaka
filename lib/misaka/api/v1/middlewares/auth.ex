defmodule Middleware.Auth.Free.V1 do
  use Maru.Middleware
  def call(conn, _opts) do
    conn
  end
end
