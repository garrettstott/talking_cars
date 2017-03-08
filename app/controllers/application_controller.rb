class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_title

  private

  def after_sign_in_path_for(resource)
    url = session[:return_url] || stored_location_for(resource) || root_path
    session[:return_url] = nil
    return url
  end

  def after_sign_up_path_for(resource)
    url = session[:return_url] || stored_location_for(resource) || root_path
    session[:return_url] = nil
    return url
  end

  def after_sign_out_path_for(resource)
    request.referrer
  end

  def set_title
    @title = @title || 'Talking Cars'
  end

end
