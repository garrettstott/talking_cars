class RepliesController < ApplicationController
  before_action :set_make, :set_model, :set_forum, :set_post
  before_action :set_title

  def index
    @replies = @post.replies.order(created_at: :asc)
    @new_reply = Reply.new
    if current_user
      @favorite = current_user.favorites.where(favoritable_type: 'Post', favoritable_id: @post.id).any?
    end
  end

  def create
    @reply = current_user.replies.new(reply_params)
    @reply.post_id = @post.id
    if @reply.save
      flash[:success] = "Your Reply was submitted successfully!"
      redirect_back(fallback_location: replies_path(@make, @model, @forum, @post))
    else
      flash[:error] = "There were errors saving your reply. #{@reply.errors.full_messages.to_sentence}"
      redirect_back(fallback_location: replies_path(@make, @model, @forum, @post))
    end
  end

    def destroy
    @reply = Reply.find(params[:reply_id])
    if @reply.update(body: "[DELETED]")
      flash[:success] = "Reply has been deleted"
    else
      flash[:error] = "Reply not deleted #{@reply.errors.full_messages}"
    end
    redirect_back(fallback_location: replies_path(@make, @model, @forum, @post))
  end

  def update 
    @reply = Reply.find(params[:reply_id])
    if @reply.update(body: params[:body])
      flash[:success] = "Reply udpated"
    else 
      flash[:error] = "Reply not updated. #{@reply.errors.full_messages.to_sentence}"
    end 
    redirect_back(fallback_location: replies_path(@make, @model, @forum, @post))
  end 


  private

  def reply_params
    params.require(:reply).permit(:body)
  end

  def set_make
    @make = Make.friendly.find(params[:make_id])
  end

  def set_model
    @model = @make.models.friendly.find(params[:model_id])
  end

  def set_forum
    @forum = @model.forums.friendly.find(params[:forum_id])
  end

  def set_post
    @post = Post.friendly.find(params[:post_id])
  end

  def set_title
    @title = "Talking Cars | #{@make.name} | #{@model.name} | #{@forum.name} | #{@post.subject}"
  end
end
