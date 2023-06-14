import consumer from "channels/consumer"

consumer.subscriptions.create("ClientesChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.turbo_stream) {
      Turbo.renderStreamMessage(data.turbo_stream)
    }
    else{
      document.getElementById("cliente_tabela").innerHTML = data;
    }
  }
});
