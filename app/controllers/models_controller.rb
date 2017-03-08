class ModelsController < ApplicationController

  before_action :set_make
  before_action :set_title

  def index
    @models = @make.models.order(name: :asc)
    if current_user
      @favorite = current_user.favorites.where(favoritable_type: 'Make', favoritable_id: @make.id).any?
    end
  end

  private

  def set_make
    @make = Make.friendly.find(params[:make_id])
  end

  def set_title
    @title = "Talking Cars | #{@make.name} | Models"
  end
end
