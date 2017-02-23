class ModelsController < ApplicationController

  before_action :set_make

  def index
    @models = @make.models.order(name: :asc)
    if current_user
      @favorite = current_user.favorites.where(make_id: @make.id).any?
    end
  end

  private

  def set_make
    @make = Make.find(params[:make_id])
  end
end
