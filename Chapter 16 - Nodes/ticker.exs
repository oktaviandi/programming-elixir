defmodule Ticker do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_id) do
    IO.puts("Name is #{@name}")
    send(:global.whereis_name(@name), {:register, client_id})
  end

  def generator(clients) do
    receive do
      {:register, client_id} ->
        IO.puts("Registering #{inspect(client_id)}")
        generator([client_id | clients])
    after
      @interval ->
        IO.puts("tick from server")

        Enum.each(clients, fn client ->
          send(client, {:tick})
        end)

        generator(clients)
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts("tock in client")
        receiver()
    end
  end
end
