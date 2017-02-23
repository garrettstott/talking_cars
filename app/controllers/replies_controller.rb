class RepliesController < ApplicationController
  before_action :set_make, :set_model, :set_forum, :set_post

  def index
    @replies = @post.replies.order(created_at: :desc)
  end


  private

  def set_make
    @make = Make.find_by_name(params[:make_name])
  end

  def set_model
    @model = @make.models.find_by_name(params[:model_name])
  end

  def set_forum
    @forum = @model.forums.find_by_name(params[:forum_name])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
