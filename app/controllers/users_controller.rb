class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
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
    @user = User.find_by_username(params[:username])
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page] || 1, per_page: 10 )
    render partial: 'posts', locals: {posts: @posts}
  end
end
