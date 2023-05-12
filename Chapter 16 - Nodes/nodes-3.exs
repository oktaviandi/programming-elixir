defmodule Ticker3 do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[], 0])
    :global.register_name(@name, pid)
  end

  def register(client_id) do
    IO.puts(@name)
    IO.inspect(:global.whereis_name(@name))
    send(:global.whereis_name(@name), {:register, client_id})
  end

  def generator(clients, current) do
    receive do
      {:register, client_id} ->
        IO.puts("Registering #{inspect(client_id)}")
        generator([client_id | clients], current)
    after
      @interval ->
        IO.puts("tick from server")

        case clients do
          [] ->
            generator(clients, current)

          _ ->
            client = Enum.at(clients, current)
            send(client, {:tick})

            next =
              case current == length(clients) - 1 do
                true -> 0
                false -> current + 1
              end

            generator(clients, next)
        end
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker3.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts("tock in client")
        receiver()
    end
  end
end
