class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def make
    make = Make.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(favoritable_type: 'Make', favoritable_id: make.id).last
      favorite.destroy
      flash[:success] = "Removed Make #{make.name} from favorites"
    else
      make.favorites.create(user_id: current_user.id)
      flash[:success] = "Added Make #{make.name} to favorites"
    end
    redirect_back(fallback_location: models_path(make))
  end

  def model
    model = Model.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(favoritable_type: 'Model', favoritable_id: model.id).last
      favorite.destroy
      flash[:success] = "Removed Model #{model.name} from favorites"
    else
      model.favorites.create(user_id: current_user.id)
      flash[:success] = "Added Model #{model.name} to favorites"
    end
    redirect_back(fallback_location: forums_path(model.make.id, model))
  end

  def forum
    forum = Forum.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(favoritable_type: 'Forum', favoritable_id: forum.id).last
      favorite.destroy
      flash[:success] = "Removed Forum #{forum.name} from favorites"
    else
      forum.favorites.create(user_id: current_user.id)
      flash[:success] = "Added Forum #{forum.name} to favorites"
    end
    redirect_back(fallback_location: posts_path(forum.model.make.id, forum.model.id, forum))
  end

  def post
    post = Post.find(params[:id])
    favorites = current_user.favorites
    if favorite = favorites.where(favoritable_type: 'Post', favoritable_id: post.id).last
      favorite.destroy
      flash[:success] = "Removed Post #{post.subject} from favorites"
    else
      post.favorites.create(user_id: current_user.id)
      flash[:success] = "Added Post #{post.subject} to favorites"
    end
    redirect_back(fallback_location: replies_path(post.forum.model.make.id, post.forum.model.id, post.forum.id, post.id))
  end

end
