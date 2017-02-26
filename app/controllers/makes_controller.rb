class MakesController < ApplicationController
  before_action :set_title

  def index
    @makes = Make.all
  end

  def set_title
    @title = "Talking Cars | Makes"
  end
end
