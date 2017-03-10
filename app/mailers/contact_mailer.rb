class ContactMailer < ApplicationMailer

  def friendly_time(time)
    time.strftime("%m/%d/%y, %I:%M %p")
  end

  default from: 'contact@talkingcars.io'

  def contact_us(user, reason, message)
    @user = user
    @message = message
    @reason = reason
    mail(
      to: 'garrettstott@gmail.com',
      subject: "[TalkingCars] contact us. #{friendly_time(Time.now)}"
    )
  end
end
