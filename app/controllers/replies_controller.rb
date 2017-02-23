class RepliesController < ApplicationController
  before_action :set_make, :set_model, :set_forum, :set_post

  def index
    @replies = @post.replies.order(created_at: :desc)
    @new_reply = Reply.new
  end

  def create
    @reply = current_user.replies.new(reply_params)
    @reply.post_id = @post.id
    if @reply.save
      flash[:success] = "Your Reply was submitted successfully!"
      redirect_to :back
    else
      flash[:error] = "There were errors saving your reply. #{@reply.errors.full_messages.to_sentence}"
      redirect_to :back
    end
  end


  private

  def reply_params
    params.require(:reply).permit(:body)
  end

  def set_make
    @make = Make.find(params[:make_id])
  end

  def set_model
    @model = @make.models.find(params[:model_id])
  end

  def set_forum
    @forum = @model.forums.find(params[:forum_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
