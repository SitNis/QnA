import consumer from "./consumer"


  consumer.subscriptions.create({ channel: "AnswersChannel", question_id: gon.question_id }, {
    connected() {
      this.perform('follow')
    },

    received(data) {
      console.log(data.author_id)
      if(gon.user_id == data.author_id) return undefined
      console.log(data)
      $('.answers').append(data.page)
    }
  })
