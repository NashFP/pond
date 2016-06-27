defmodule Pond.Grid do
  @x_size 80
  @y_size 30
  defp empty_row do
    Enum.map(1..@x_size, fn _ -> :empty end)
  end
  
  defp empty_grid do
    Enum.map(1..@y_size, fn _ -> empty_row end)
  end

  defp do_fetch_at(grid, x, _) when x < 0, do: nil
  defp do_fetch_at(grid, _, y) when y < 0, do: nil
  defp do_fetch_at(grid, x, y) do
    case Enum.at(grid, x) do
      nil -> nil
      row -> Enum.at(row, y)
    end

  end

  defp set_in_row(row, y, val) do
      row 
      |> List.update_at(y, fn _ -> val end)
  end

  defp do_set_at(grid, x, y, val) do
    grid
    |> List.update_at(x, &set_in_row(&1, y, val))
  end

  def start_link do
    Agent.start_link(&empty_grid/0, name: __MODULE__)
  end

  def fetch_all() do
    Agent.get(__MODULE__, fn grid -> grid end)
  end

  def fetch_at(x, y) do
    Agent.get(__MODULE__, fn grid -> 
      do_fetch_at(grid, x, y)
    end)
  end

  def create_neighbor_coords(x, y) do
    for a <- [x-1, x, x+1],
      b <- [y-1, y, y+1],
      not (a == x and b == y),
      do: [a, b]
  end

  def create_moveable_coords(x, y) do
      for a <- (x-5)..(x+5), b <- (y-5)..(y+5), do: [a, b]
  end

  def fetch_random_empty_space(x, y) do
    Agent.get(__MODULE__, fn grid ->
      create_moveable_coords(x, y)
      |> Enum.map(fn ([x, y]) -> {x, y, do_fetch_at(grid, x, y)} end)
      |> Enum.filter(&(elem(&1, 2) == :empty))
      |> Enum.random
    end)
  end


  def fetch_adjacent(x, y) do
    neighbor_coords = create_neighbor_coords(x, y)
    Agent.get(__MODULE__, fn grid ->
      create_neighbor_coords(x, y)
      |> Enum.map(fn [x, y] -> do_fetch_at(grid, x, y) end)
      |> Enum.filter(fn x -> not is_nil x end)
    end)
  end

  def set_at(x, y, val) do
    Agent.update(__MODULE__, fn grid ->
      do_set_at(grid, x, y, val)
    end)
  end
  
end
