class PostsController < ApplicationController

  before_action :set_make, :set_model, :set_forum

  def index
    @posts = @forum.posts.includes(:user).order(updated_at: :desc)
    @new_post = Post.new
    if current_user
      @favorite = current_user.favorites.where(favoritable_type: 'Forum', favoritable_id: @forum.id).any?
    end
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.forum_id = @forum.id
    if @post.save
      flash[:success] = "Your post was submitted successfully!"
      redirect_to replies_path(@make, @model, @forum, @post)
    else
      flash[:error] = "There were errors saving your post. #{@post.errors.full_messages.to_sentence}"
      redirect_back(fallback_location: replies_path(@make, @model, @forum, @post))
    end
  end

  private

  def post_params
    params.require(:post).permit(:subject, :body)
  end

  def set_make
    @make = Make.find_by_name(params[:make_name])
  end

  def set_model
    @model = @make.models.find_by_name(params[:model_name])
  end

  def set_forum
    @forum = @model.forums.find(params[:forum_id])
  end
end
