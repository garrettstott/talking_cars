class ForumsController < ApplicationController
  before_action :set_make, :set_model

  def index
    forums = @model.forums
    @general = forums.where(category: 'General')
    @technical = forums.where(category: 'Technical')
    @classified = forums.where(category: 'Classified')
    if current_user
      @favorite = current_user.favorites.where(model_id: @model.id).any?
    end
  end

  private

  def set_make
    @make = Make.find(params[:make_id])
  end

  def set_model
    @model = @make.models.find(params[:model_id])
  end
end
