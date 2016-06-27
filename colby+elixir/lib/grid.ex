defmodule Pond.Grid do
  defp empty_row do
    Enum.map(1..128, fn _ -> :empty end)
  end
  
  defp empty_grid do
    Enum.map(1..64, fn _ -> empty_row end)
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
    for ex <- (x-1)..(x+1),
      why <- (y-1)..(y+1) do
      [ex, why]
    end
  end

  def fetch_adjacent(x, y) do
    neighbor_coords = create_neighbor_coords(x, y)
    Agent.get(__MODULE__, fn grid ->
      neighbor_coords
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
