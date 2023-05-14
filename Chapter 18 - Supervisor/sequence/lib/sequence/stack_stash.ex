defmodule Sequence.StackStash do
  use GenServer
  @me __MODULE__
  def start_link(initial) do
    GenServer.start_link(__MODULE__, initial, name: @me)
  end

  def get() do
    GenServer.call(@me, {:get})
  end

  def update(value) do
    GenServer.cast(@me, {:update, value})
  end

  # Server implementation
  def init(initial) do
    {:ok, initial}
  end

  def handle_call({:get}, _from, current) do
    {:reply, current, current}
  end

  def handle_cast({:update, value}, _current_number) do
    {:noreply, value}
  end

  def terminate(reason, current) do
    Sequence.Stash.update(current)
  end
end
