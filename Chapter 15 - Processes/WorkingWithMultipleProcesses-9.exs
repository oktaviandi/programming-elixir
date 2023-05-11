defmodule FileReader do
  def reader(client) do
    send(client, {:ready, self()})

    receive do
      {:count, filename, word, client} ->
        send(client, {:answer, filename, word_counter(filename, word), self()})
        reader(client)

      {:shutdown} ->
        exit(:normal)
    end
  end

  defp word_counter(filename, word) do
    content = File.read!(filename)
    tokens = String.split(content, word)
    length(tokens) - 1
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, directory, word) do
    {:ok, files} = File.ls(directory)
    files = Enum.map(files, fn file -> Path.join(directory, file) end)

    1..num_processes
    |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
    |> schedule_processes(files, word, Map.new())
  end

  defp schedule_processes(processes, queue, word, results) do
    receive do
      {:ready, pid} when queue != [] ->
        [head | tail] = queue
        send(pid, {:count, head, word, self()})
        schedule_processes(processes, tail, word, results)

      {:ready, pid} ->
        send(pid, {:shutdown})

        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, word, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      {:answer, filename, counter, _pid} ->
        schedule_processes(processes, queue, word, Map.put(results, filename, counter))
    end
  end
end

defmodule Runner do
  def run(directory, word) do
    Enum.each(1..100, fn num_processes ->
      {time, result} =
        :timer.tc(
          Scheduler,
          :run,
          [num_processes, FileReader, :reader, directory, word]
        )

      if num_processes == 1 do
        IO.puts("\n #   time (s)")
      end

      :io.format("~2B     ~.2f~n", [num_processes, time / 1_000_000.0])
    end)
  end
end

defmodule FileGenerator do
  def generate_file(directory, no_of_files, word) do
    Enum.each(1..no_of_files, fn file_number ->
      random_number = :random.uniform(1000)

      content =
        case rem(random_number, 2) do
          0 -> word
          _ -> "Whatever"
        end

      file_path = "#{directory}/file#{file_number}.txt"
      content = "This is file #{file_number} and foobar #{content}"
      File.write(file_path, content)
    end)
  end
end
