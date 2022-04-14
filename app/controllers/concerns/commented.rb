module Commented
  extend ActiveSupport::Concern

  included do
    before_action :load_commentable, only: %i[comment]
    after_action :publish_comment, only: %i[comment]
  end

  def comment
    @comment = @commentable.comments.build(comment_params)
    current_user.comments << @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def model_klass
    controller_name.classify.constantize
  end

  def load_commentable
    @commentable = model_klass.find(params[:id])
  end

  def publish_comment
    return if @comment.errors.any?

    question = @commentable.is_a?(Question) ? @commentable : @commentable.question
    ActionCable.server.broadcast(
      "comments_#{question.id}",
      author_id: @comment.user_id,
      commentable_id: @comment.commentable_id,
      page: render_comment
      )
  end

  def render_comment
    ApplicationController.render(
      partial: 'comments/comment',
      locals: {
        comment: @comment,
      }
    )
  end
end
