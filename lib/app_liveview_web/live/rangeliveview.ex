defmodule AppLiveviewWeb.RangeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    Process.send_after(self(), :update, 1000)
    {
    :ok,
    assign(
    socket,
    time:  1,
    progress: 1,
    message: "....",
    message2: "Enviando cada segundo a servidor"
    )
    }
  end

  def render(assigns) do
    #Phoenix.View.render(AppLiveviewWeb.PageView, "index.html", assigns)
   ~L"""
    <h1 class="display-3 text-center bg-light">Llamada de cliente a servidor</h1>
    <div class="row justify-content-md-center">
        <div class="col-lg-1">
        <h3 style="color:#F05423"> Cliente </h3>
        </div>
        <div class="col-lg-2">
        <h3 style="color:#453635"> Petición </h3>
          <div class="progress">
            <div class="progress-bar progress-bar-striped bg-info" role="progressbar" style="width: <%= @progress %>%" aria-valuenow=" <%= @progress %>" aria-valuemin="1" aria-valuemax="100"></div>
          </div>
        </div>
        <div class="col col-lg-2">
        <h3 style="color:#F05423"> Servidor </h3>
        </div>
    </div>

    <h2>
      <%= @message2 %>
    </h2>
    <div class="container">

      <div class="row justify-content-md-center">
        <div class="col-lg-3">
          <label for="customRange1" class="form-label" >Selecciona lapso de tiempo</label>
          <input type="range" min="1" max="10" class="form-range" id="customRange1" value="<%= @time %>" phx-click="onChange">
        </div>
      </div>

    </div>

    """
  end

  def handle_info(:update, socket) do


    Process.send_after(self(), :reset, 1000 )
    {
      :noreply,
      assign(
      socket,
      progress: 100
      )
    }
  end

  def handle_info(:reset, socket) do

    time  = socket.assigns.time * 1000
    IO.puts( time )
    Process.send_after(self(), :update, time)
    {
      :noreply,
      assign(
        socket,
        progress: 0
      )
    }
  end

  def handle_event("onChange", %{"value" => value}=data, socket) do
    IO.inspect data
    message = "Enviando cada #{value} segundo(s)"
    time = String.to_integer(value)
    {
    :noreply,
    assign(
      socket,
      message2: message,
      time: time
    )
   }

  end


end
