class AnswersChannel < ApplicationCable::Channel
  def follow
    stream_from "answers_#{params[:question_id]}"
  end
end
