import consumer from "./consumer"

consumer.subscriptions.create({ channel: "CommentsChannel", question_id: gon.question_id }, {
  connected() {
    this.perform('follow')
  },

  received(data) {
    if(gon.user_id == data.author_id) return undefined
    $('#' + data.commentable_id + ".comments").append(data.page);
  }
});
