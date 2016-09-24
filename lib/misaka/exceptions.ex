defmodule Misaka.Exceptions do
  defmodule FormException do
    defexception [:field, :value, :msg]
    def message(e) do
      "Form Field Error: #{e.field}"
    end
  end

  defmodule UnauthorizedException do
    defexception [:msg]
    def message(_e) do
      "Unauthorized"
    end
  end

  defmodule RecordNotFoundException do
    defexception [:msg]
    def message(_e) do
      "Record Not Found"
    end
  end

end
