defmodule Ticker4 do
  @interval 2000
  @master :master

  def register do
    IO.puts("Register here")
    pid = :global.whereis_name(@master)
    IO.inspect(pid)
    IO.inspect(is_pid(pid))

    case is_pid(pid) do
      true ->
        send(pid, {:register, self})
        follow()

      false ->
        :global.register_name(@master, self)
        lead([self], 0)
    end
  end

  def lead(clients, next) do
    receive do
      {:register, client_id} ->
        IO.puts("Register #{inspect(client_id)}")
        lead(clients ++ [client_id], next)
    after
      @interval ->
        IO.puts("Interval server")
        IO.inspect(clients)

        if length(clients) == 1 do
          lead(clients, next)
        else
          next = next + 1
          next_client = Enum.at(clients, next)

          next =
            case next == length(clients) - 1 do
              true -> 0
              false -> next + 1
            end

          send(next_client, {:tick, clients, next})
          follow()
        end
    end
  end

  def follow do
    receive do
      {:tick, clients, next} ->
        IO.puts("Tock in client")
        :global.unregister_name(@master)
        :global.register_name(@master, self())
        lead(clients, next)
    end
  end
end
