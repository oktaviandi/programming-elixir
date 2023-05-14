defmodule Sequence.OtpServer1 do
  use GenServer

  #####
  # External API

  def start_link(initial_values) do
    GenServer.start_link(__MODULE__, initial_values, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do: GenServer.cast(__MODULE__, {:push, value})


  def init(initial_values) do
    {:ok, initial_values}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, value}, current_value) do
    {:noreply, [value | current_value]}
  end
end
