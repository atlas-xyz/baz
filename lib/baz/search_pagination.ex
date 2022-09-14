defmodule Baz.SearchPagination do
  @type page_number :: pos_integer
  @type page_size :: pos_integer

  @spec default_page_number :: page_number
  def default_page_number, do: 1

  @spec default_page_size :: page_size
  def default_page_size, do: 50
end
