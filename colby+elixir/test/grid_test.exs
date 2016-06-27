defmodule PondGridTest do
  use ExUnit.Case
  doctest Pond.Grid
  alias Pond.Grid

  setup do
    Grid.start_link
    :ok
  end

  test "create_neighbors" do
    neighbors = Grid.create_neighbor_coords(20, 20)
    assert neighbors == [
      [19, 19], [19, 20], [19, 21],
      [20, 19], [20, 20], [20, 21],
      [21, 19], [21, 20], [21, 21]
    ]
  end

  test "out of bounds fetch" do
    assert Grid.fetch_at(-1, 0) == nil
    assert Grid.fetch_at(0, -1) == nil
    assert Grid.fetch_at(1000, 0) == nil
    assert Grid.fetch_at(0, 1000) == nil
  end

  test "fetch adjacent" do
    neighbors = Grid.fetch_adjacent(30, 30)
    assert Enum.count(neighbors) == 9

    edge_neighbors = Grid.fetch_adjacent(0, 30)
    assert Enum.count(edge_neighbors) == 6
  end

end
