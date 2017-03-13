class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_title

  after_action :store_location

  private

  def set_title
    @title = @title || 'Talking Cars'
  end

  def store_location 
    if (
        request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/password" &&
        request.fullpath != "/users/sign_out" &&
        !request.xhr?
       )
      session[:return_url] = request.fullpath
    end 
  end 

end
