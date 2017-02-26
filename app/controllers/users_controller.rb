class UsersController < ApplicationController

  before_action :set_user
  before_action :set_title

  def show
    @fav_makes = @user.favorites.where(favoritable_type: 'Make')
    @fav_models = @user.favorites.where(favoritable_type: 'Model')
    @fav_forums = @user.favorites.where(favoritable_type: 'Forum')
    @fav_posts = @user.favorites.where(favoritable_type: 'Post')
    @vehicles = @user.vehicles
    if current_user
      @new_vehicle = Vehicle.new
    end
  end

  def posts
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page] || 1, per_page: 5 )
    render partial: 'posts', locals: {posts: @posts, user: @user}
  end

  private

  def set_user
    @user = User.find_by_username(params[:username])
  end

  def set_title
    @title = "Talking Cars | #{@user.username}"
  end
end
