import consumer from "./consumer"

consumer.subscriptions.create("QuestionsChannel", {
  connected() {
    this.perform('follow')
  },

  disconnected() {
  },

  received(data) {
    $('.questions').append(data)
  }
});
