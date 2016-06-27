defmodule Pond.Entity do
  use GenServer
  alias Pond.Grid

  def start_link(params, opts \\ []) do
    GenServer.start_link __MODULE__, params, opts
  end

  # Server side
  def init({type, x, y}) do
    GenServer.cast(self, :move)
    {:ok, {type, x, y}}
  end

  def handle_cast(:move, {type, x, y}) do
    neighbors = Grid.fetch_adjacent(x, y)
  end
end
