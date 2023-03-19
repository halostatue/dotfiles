import_if_available Ecto.Query
import_if_available Mex

defmodule IEx.HistoryHelpers do
  def save_history(filename \\ "iex_history.exs") do
    File.write!(filename, Enum.reverse(:group_history.load()))
  end
end

defmodule IEx.Bucket do
  @moduledoc "A trace bucket."

  @doc "Initialize the trace bucket."
  def new, do: :ets.new(__MODULE__, [:named_table, :public])

  @doc "Remove item identified by `key` from the trace bucket."
  def delete(key), do: :ets.delete(__MODULE__, key)

  @doc "Clear the trace bucket."
  def clear, do: :ets.delete_all_objects(__MODULE__)

  @doc "Browse the trace bucket."
  def i, do: :ets.i(__MODULE__)

  @doc "Info on the trace bucket."
  def info, do: :ets.info(__MODULE__)

  @doc "Insert `items` into the trace bucket. Should be a tuple-list or a tuple."
  def insert(items) when is_list(items), do: :ets.insert(__MODULE__, items)

  def insert(item) when is_tuple(item), do: :ets.insert(__MODULE__, item)

  @doc "Insert an item `value` with `key`."
  def insert(key, value), do: :ets.insert(__MODULE__, {key, value})

  @doc "Dump the trace bucket as a list."
  def list, do: :ets.tab2list(__MODULE__)

  @doc "Take (remove) item identified by `key` from the trace bucket."
  def take(key), do: :ets.take(__MODULE__, key)
end

alias IEx.Bucket, as: B
B.new
