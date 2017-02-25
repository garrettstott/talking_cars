class ModelsController < ApplicationController

  before_action :set_make

  def index
    @models = @make.models.order(name: :asc)
    if current_user
      @favorite = current_user.favorites.where(favoritable_type: 'Make', favoritable_id: @make.id).any?
    end
  end

  private

  def set_make
    @make = Make.find_by_name(params[:make_name])
  end
end
