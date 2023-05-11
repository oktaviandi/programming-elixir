defmodule Processes3 do
  def run do
    spawn_link(Processes3, :kiddo, [self])

    :timer.sleep(600)

    receive_notification
  end

  def kiddo(parent) do
    send(parent, "Send #{:rand.uniform(1000)}")
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
