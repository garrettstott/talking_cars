class ContactMailer < ApplicationMailer
  default from: 'contact@talkingcars.io'

  def contact_us(user, reason, message)
    @user = user
    @message = message
    @reason = reason
    mail(
      to: 'garrettstott@gmail.com',
      subject: "[TalkingCars] contact us. #{Time.now}"
    )
  end
end
