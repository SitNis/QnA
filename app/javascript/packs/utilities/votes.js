$(document).on('turbolinks:load', function(){
  $('.vote > div').on('ajax:success', function(e) {
    const votable = e.detail[0];
    let score = votable.score;
    let id = votable.id;

    $('.votable-score-'+id).html(score)
  })
    .on('ajax:error', function(e) {
      const errors = e.detail[0];

      $('.vote-errors').append()
      $.each(errors, function(index, value) {
        $('.vote-errors').append('<p>' + value + '</p>')
      })
    })
})
