class MessagesController < ApplicationController
  before_action :authenticate_user!

  def all
  end
end
