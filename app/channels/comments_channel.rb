class CommentsChannel < ApplicationCable::Channel
  def follow
    stream_from "comments_#{params[:question_id]}"
  end
end
