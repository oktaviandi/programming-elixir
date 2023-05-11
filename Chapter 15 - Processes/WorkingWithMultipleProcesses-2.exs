defmodule Processes do
  def run do
    first_process = spawn(Processes, :first, [])
    second_process = spawn(Processes, :second, [])

    send first_process, {self, "Betty"}
    send second_process, {self, "Fred"}

    receive do
      {_, value} -> IO.puts "Replied #{value}"
    end

    receive do
      {_, value} -> IO.puts "Replied #{value}"
    end
  end

  def first do
    receive do
      {sender, value} -> send sender, {self, "Hi #{value} from first"}
    end
  end

  def second do
    receive do
      {sender, value} -> send sender, {self, "Hi #{value} from second"}
    end
  end
end
