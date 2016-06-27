defmodule Pond do

  alias Pond.Entity
  alias Pond.Grid

  def rand_empty_spot() do
    x = :random.uniform(64) - 1
    y = :random.uniform(128) - 1
    case Grid.fetch_at(x, y) do
      :empty -> [x, y]
      _ -> rand_empty_spot
    end
  end

  def add_entity(type) do
    [x, y] = rand_empty_spot
    Grid.set_at(x, y, type)
    Entity.start_link({type, x, y})
  end

  def add_frogs() do
    Enum.map(1..3000, fn(_) -> add_entity(:frog) end)
  end

  def add_turtles() do
    Enum.map(1..3000, fn(_) -> add_entity(:turtle) end)
  end
  
  def main do
    Grid.start_link
    frogs = add_frogs
    turtles = add_turtles
  end

end
