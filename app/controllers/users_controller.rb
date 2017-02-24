class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    @makes = @user.favorites.where.not(make_id: nil).includes(:make)
    @models = @user.favorites.where.not(model_id: nil).includes(:model)
    @forums = @user.favorites.where.not(forum_id: nil).includes(:forum)
    @posts = @user.favorites.where.not(post_id: nil).includes(:post)
  end
end
