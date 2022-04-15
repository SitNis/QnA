import consumer from "./consumer"

consumer.subscriptions.create({ channel: "AnswersChannel", question_id: gon.question_id }, {
  connected() {
    this.perform('follow')
  },

  received(data) {
    if(gon.user_id == data.author_id) return undefined
    console.log(data)
    $('.answers').append(data.page)
  }
})
