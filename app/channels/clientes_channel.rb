class ClientesChannel < ApplicationCable::Channel
  def subscribed
    puts("====== connect =======")
    stream_from "clientes"
  end

  def unsubscribed
    puts("====== desconect =======")
    # Any cleanup needed when channel is unsubscribed
  end
end
