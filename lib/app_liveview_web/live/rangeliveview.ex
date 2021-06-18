defmodule AppLiveviewWeb.RangeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    Process.send_after(self(), :update, 100)
    {
    :ok,
    assign(
    socket,
    time:  100,
    init_request: true,
    request: [1],
    message: "....",
    message2: "Sending every 100 ms to server"
    )
    }
  end

  def render(assigns) do
    Phoenix.View.render(AppLiveviewWeb.LayoutView, "rangeliveview.html", assigns)
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :reset, socket.assigns.time )
    {
      :noreply,
      assign(
      socket,
      init_request: true,
      request: [1 | socket.assigns.request]
      )
    }
  end

  def handle_info(:reset, socket) do

    time  = socket.assigns.time
    IO.puts( time )
    Process.send_after(self(), :update, time)
    {
      :noreply,
      assign(
        socket,
        init_request: false
      )
    }
  end

  def handle_event("onChange", %{"value" => value}=data, socket) do
    IO.inspect data
    {
    :noreply,
    assign(
      socket,
      message2: "Sending every  #{value} ms to server",
      time:  String.to_integer(value)
    )
   }

  end


end
