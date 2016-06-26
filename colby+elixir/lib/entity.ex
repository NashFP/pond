defmodule Pond.Entity do
  use GenServer

  def start_link(params, opts \\ []) do
    GenServer.start_link __MODULE__, params, opts
  end

  # Server side
  def init(%{type: type, x: x, y: y}) do
    {:ok, %{type: type, x: x, y: y}}
  end
end
