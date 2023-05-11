"""
Result running on M1 Mac Mini with 8GB of RAM.
iex(30)> Runner.run
 #   time (s)
 1     3.73
 2     1.91
 3     1.38
 4     1.25
 5     1.09
 6     1.07
 7     0.89
 8     0.92
 9     0.93
10     0.90
"""

defmodule FibSolver do
  def fib(client) do
    send(client, {:ready, self()})

    receive do
      {:fib, n, client} ->
        send(client, {:answer, n, fib_calc(n), self()})
        fib(client)

      {:shutdown} ->
        exit(:normal)
        # code
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    1..num_processes
    |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when queue != [] ->
        [head | tail] = queue
        send pid, {:fib, head, self()}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end
end

defmodule Runner do
  def run do
    to_process = List.duplicate(37, 20)
    Enum.each 1..10, fn num_processes ->
      {time, result} = :timer.tc(
        Scheduler, :run, [num_processes, FibSolver, :fib, to_process]
      )

      if num_processes == 1 do
        IO.puts "\n #   time (s)"
      end
      :io.format "~2B     ~.2f~n", [num_processes, time/1000000.0]
    end
  end
end
