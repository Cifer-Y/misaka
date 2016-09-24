defmodule Misaka.API do
  use Maru.Router
  use MaruSwagger
  alias Misaka.Exceptions

  prefix :api

  before do
    plug Plug.Logger
    plug Plug.Parsers,
      pass: ["*/*"],
      json_decoder: Poison,
      parsers: [:urlencoded, :json, :multipart]
  end

  get do
    conn |> json(%{name: "Misaka", version: Misaka.version})
  end

  swagger at:      "/swagger",
          pretty:  true,
          except:  [:prod, :stag, :test]

  mount Routers.V1

  rescue_from Exceptions.UnauthorizedException, as: e do
    IO.puts """
    \n
    401 unauthorized e =============== #{ctext(:cyan, e)} \n
    401 unauthorized stacktrace ========= #{ctext(:yellow, System.stacktrace)} \n
    401 unauthorized conn ========= #{ctext(:green, conn)} \n
    """
    conn
    |> put_status(401)
    |> json(%{message: e.msg})
  end

  rescue_from Exceptions.RecordNotFoundException, as: e do
    IO.puts """
    \n
    417 record not found e =============== #{ctext(:cyan, e)} \n
    417 record not found stacktrace ========= #{ctext(:yellow, System.stacktrace)} \n
    417 record not found conn ========= #{ctext(:green, conn)} \n
    """
    conn
    |> put_status(417)
    |> json(%{message: e.msg})
  end

  rescue_from Exceptions.FormException, as: e do
    IO.puts """
    \n
    417 form e =============== #{ctext(:cyan, e)} \n
    417 form stacktrace ========= #{ctext(:yellow, System.stacktrace)} \n
    417 form conn ========= #{ctext(:green, conn)} \n
    """
    conn
    |> put_status(417)
    |> json(%{field: e.field, value: e.value, message: e.msg})
  end

  rescue_from Maru.Exceptions.InvalidFormatter, as: e do
    IO.puts """
    \n
    417 invalidformatter e =============== #{ctext(:cyan, e)} \n
    417 invalidformatter stacktrace ========= #{ctext(:yellow, System.stacktrace)} \n
    417 invalidformatter conn ========= #{ctext(:green, conn)} \n
    """
    msg =
      case e.reason do
        :illegal -> "该参数非法"
        :required -> "该参数必传"
      end
    conn
    |> put_status(417)
    |> json(%{field: e.param, message: msg})
  end

  rescue_from Maru.Exceptions.Validation, as: e do
    IO.puts """
    \n
    417 validation e =============== #{ctext(:cyan, e)} \n
    417 validation stacktrace ========= #{ctext(:yellow, System.stacktrace)} \n
    417 validation conn ========= #{ctext(:green, conn)} \n
    """
    conn
    |> put_status(417)
    |> json(%{field: e.param, message: "Validation Error"})
  end


  rescue_from :all, as: e do
    IO.puts """
    \n
    500 e =============== #{ctext(:cyan, e)} \n
    500 stacktrace ========= #{ctext(:yellow, System.stacktrace)}
    500 conn ========= #{ctext(:green, conn)} \n
    """

    conn
    |> put_status(500)
    |> json("Server Error")
  end

  defp ctext(color, content) do
    IO.ANSI.format([color, :bright, "#{inspect content}"], true)
  end

end
