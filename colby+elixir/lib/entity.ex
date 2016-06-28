defmodule Pond.Entity do
  use GenServer
  alias Pond.Grid

  @wait_time 500..1500

  def start_link(params, opts \\ []) do
    GenServer.start_link __MODULE__, params, opts
  end

  # Server side
  def init({type, x, y}) do
    GenServer.cast(self, :move)
    {:ok, {type, x, y}}
  end

  def do_move(count, type, x, y) when count > 3, do: {type, x, y}
  def do_move(count, type, x, y) do
    {a, b} = Grid.fetch_random_empty_space(x, y)
    Grid.set_at(x, y, :empty)
    Grid.set_at(a, b, type)
    {type, a, b}
  end


  def handle_cast(:move, {type, x, y}) do
    @wait_time |> Enum.random |> Process.sleep
    neighbors = Grid.fetch_adjacent(x, y)
    count = neighbors |> Enum.filter(&(&1 == type)) |> length
    new_state = do_move(count, type, x, y)
    GenServer.cast(self, :move)
    {:noreply, new_state}
  end
end
