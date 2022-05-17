defmodule Baz.Migrations do
  @spec table_and_index_prefix :: atom | nil
  def table_and_index_prefix do
    Application.get_env(:baz, :table_and_index_prefix, nil)
  end
end
