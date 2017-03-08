class ForumsController < ApplicationController
  before_action :set_make, :set_model
  before_action :set_title

  def index
    forums = @model.forums
    @general = forums.where(category: 'General')
    @technical = forums.where(category: 'Technical')
    @classified = forums.where(category: 'Classified')
    if current_user
      @favorite = current_user.favorites.where(favoritable_type: 'Model', favoritable_id: @model.id).any?
    end
  end

  private

  def set_make
    @make = Make.friendly.find(params[:make_id])
  end

  def set_model
    @model = @make.models.friendly.find(params[:model_id])
  end

  def set_title
    @title = "Talking Cars | #{@make.name} | #{@model.name} | Forums"
  end
end
