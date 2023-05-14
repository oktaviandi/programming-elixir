defmodule Sequence.StackServer do
  use GenServer

  #####
  # External API

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value), do: GenServer.cast(__MODULE__, {:push, value})


  def init(_) do
    {:ok, Sequence.StackStash.get()}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, value}, current_value) do
    {:noreply, [value | current_value]}
  end


end
