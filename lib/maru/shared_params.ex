defmodule SharedParams do
  use Maru.Helper
  params :paging do
    optional :page, type: Integer, default: 1
    optional :page_count, type: Integer, default: 20
  end
end
