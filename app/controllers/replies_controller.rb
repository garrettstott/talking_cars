class RepliesController < ApplicationController
  before_action :set_make, :set_model, :set_forum, :set_post

  def index
    @replies = @post.replies.order(created_at: :desc)
  end


  private

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
