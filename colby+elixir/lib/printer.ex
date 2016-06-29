defmodule Pond.Printer do
  use GenServer
  alias Pond.Grib

  def start_link() do
    GenServer.start_link __MODULE__, :ok, name: :printer
  end

  def print() do
    GenServer.call(:printer, :print)
  end

  # Server side
  def init(_) do
    {:ok, :ok}
  end

  def print_symbol(sym) do
    case sym do
      :frog -> "O"
      :turtle -> "X"
      _ -> "_"
    end
  end

  def print_row(row) do
    row
    |> Enum.map(&print_symbol/1)
    |> Enum.join("")
    |> IO.puts
  end

  def print_grid do
    grid = Pond.Grid.fetch_all
    IEx.Helpers.clear
    IO.puts(String.duplicate(" ", 64))
    grid |> Enum.each(&print_row/1)
    IO.puts(String.duplicate(" ", 64))
  end

  def handle_call(:print, _, _) do
    print_grid
    {:reply, :ok, :ok}
  end
end
