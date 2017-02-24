class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def make
    make = Make.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(make_id: make.id).last
      favorite.destroy
      flash[:success] = "Removed Make #{make.name} from favorites"
    else
      current_user.favorites.create(make_id: make.id)
      flash[:success] = "Added Make #{make.name} to favorites"
    end
    redirect_to :back
  end

  def model
    model = Model.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(model_id: model.id).last
      favorite.destroy
      flash[:success] = "Removed Model #{model.name} from favorites"
    else
      current_user.favorites.create(model_id: model.id)
      flash[:success] = "Added Model #{model.name} to favorites"
    end
    redirect_to :back
  end

  def forum
    forum = Forum.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(forum_id: forum.id).last
      favorite.destroy
      flash[:success] = "Removed Forum #{forum.name} from favorites"
    else
      current_user.favorites.create(forum_id: forum.id)
      flash[:success] = "Added Forum #{forum.name} to favorites"
    end
    redirect_to :back
  end

  def post
    post = Post.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(post_id: post.id).last
      favorite.destroy
      flash[:success] = "Removed Post #{post.subject.truncate(20)} from favorites"
    else
      current_user.favorites.create(post_id: post.id)
      flash[:success] = "Added Post #{post.subject.truncate(20)} to favorites"
    end
    redirect_to :back
  end

end
