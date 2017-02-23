class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def make
    make = Make.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(make_id: params[:id]).last
      favorite.destroy
      flash[:success] = "Removed #{make.name} from favorites"
    else
      current_user.favorites.create(make_id: params[:id])
      flash[:success] = "Added #{make.name} to favorites"
    end
    redirect_to :back
  end

  def model
    model = Model.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(model_id: params[:id]).last
      favorite.destroy
      flash[:success] = "Removed #{model.name} from favorites"
    else
      current_user.favorites.create(model_id: params[:id])
      flash[:success] = "Added #{model.name} to favorites"
    end
    redirect_to :back
  end

  def forum
    forum = Forum.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(forum_id: params[:id]).last
      favorite.destroy
      flash[:success] = "Removed #{forum.name} from favorites"
    else
      current_user.favorites.create(forum_id: params[:id])
      flash[:success] = "Added #{forum.name} to favorites"
    end
    redirect_to :back
  end

  def post
    post = Post.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(post_id: params[:id]).last
      favorite.destroy
      flash[:success] = "Removed #{post.subject.truncate(20)} from favorites"
    else
      current_user.favorites.create(post_id: params[:id])
      flash[:success] = "Added #{post.subject.truncate(20)} to favorites"
    end
    redirect_to :back
  end

end
