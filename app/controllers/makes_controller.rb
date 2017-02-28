class MakesController < ApplicationController
  before_action :set_title

  def index
    @makes = Make.all.order(name: :asc)
  end

  def set_title
    @title = "Talking Cars | Makes"
  end
end
