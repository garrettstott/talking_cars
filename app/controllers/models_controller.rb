class ModelsController < ApplicationController

  before_action :set_make

  def index
    @models = @make.models.order(name: :asc)
  end

  private

  def set_make
    @make = Make.find(params[:make_id])
  end
end
