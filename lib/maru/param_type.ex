defmodule Maru.Types.Amount do
  use Maru.Type

  @doc """
  input string format: 100 | 100.2 | 100.02 | 100.20
  """
  def parse("", _), do: 0
  def parse("-" <> _ = string, _) do
    Misaka.Exceptions.FormException |> raise(field: :amount, value: string, msg: "格式错误: 不接受负数")
  end
  def parse("+" <> string, opts) do
    parse(string, opts)
  end
  def parse(string, _) do
    if String.contains?(string, ".") do
      [yuan, rest] = string |> String.split(".")
      case String.length(rest) do
        1 ->
          String.to_integer(yuan) * 100 + String.to_integer(rest) * 10
        2 ->
          [jiao, fen] = String.codepoints(rest)
          String.to_integer(yuan) * 100 + String.to_integer(jiao) * 10 + String.to_integer(fen)
        _ ->
          Misaka.Exceptions.FormException
          |> raise(field: :amount, value: string, msg: "格式错误: 最多两位小数")
      end
    else
      String.to_integer(string) * 100
    end
  end
end

defmodule Maru.Types.Date do
  use Maru.Type

  @doc """
  input date format: 2013-12-25
  """
  def parse(date, _) do
    Calendar.Date.Parse.iso8601!(date)
  end
end
