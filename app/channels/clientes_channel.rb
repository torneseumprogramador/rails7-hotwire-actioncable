class ClientesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "clientes"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
