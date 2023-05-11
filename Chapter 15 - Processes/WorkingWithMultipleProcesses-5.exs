defmodule Processes5 do
  def run do
    spawn_monitor(Processes5, :kiddo, [self])

    :timer.sleep(600)

    receive_notification
  end

  def kiddo(parent) do
    send parent, "Hi parent"
    raise "Don't cry for me :)"
  end

  def receive_notification do
    receive do
      value ->
        IO.puts("From kiddo #{value}")
        receive_notification
    after
      500 -> IO.puts("Done")
    end
  end
end
