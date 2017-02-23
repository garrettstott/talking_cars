class ForumsController < ApplicationController
  before_action :set_make, :set_model

  def index
    forums = @model.forums
    @general = forums.where(category: 'General')
    @technical = forums.where(category: 'Technical')
    @classified = forums.where(category: 'Classified')
  end

  private

  def set_make
    @make = Make.find_by_name(params[:make_name])
  end

  def set_model
    @model = @make.models.find_by_name(params[:model_name])
  end
end
