class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    @makes = @user.favorites.where(favoritable_type: 'Make')
    @models = @user.favorites.where(favoritable_type: 'Model')
    @forums = @user.favorites.where(favoritable_type: 'Forum')
    @posts = @user.favorites.where(favoritable_type: 'Post')
    @vehicles = @user.vehicles
    if current_user
      @new_vehicle = Vehicle.new
    end
  end
end
