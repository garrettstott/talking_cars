class MailersController < ApplicationController

  def contact_us
    user = {name: params[:name], email: params[:email]}
    reason = params[:reason]
    message = params[:message]
    ContactMailer.contact_us(user, reason, message).deliver_later
    flash[:success] = "Thank your for contacting us!"
    redirect_back(fallback_location: root_path)
  end
end
