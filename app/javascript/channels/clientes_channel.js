import consumer from "channels/consumer";

consumer.subscriptions.create("ClientesChannel", {
  connected() {
    // alert('conectou')
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // alert('desconectou')
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
