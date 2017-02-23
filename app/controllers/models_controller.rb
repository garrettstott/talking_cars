class ModelsController < ApplicationController

  before_action :set_make

  def index
    @models = @make.models.order(name: :asc)
  end

  private

  def set_make
    @make = Make.find_by_name(params[:make_name])
  end
end
