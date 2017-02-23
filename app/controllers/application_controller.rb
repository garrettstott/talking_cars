class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    url = session[:return_url] || root_path
    session[:return_url] = nil
    return url
  end

  def after_sign_up_path_for(resource)
    url = session[:return_url] || root_path
    session[:return_url] = nil
    return url
  end

  def after_sign_out_path_for(resource)
    request.referrer
  end 

end
