# localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def contact_us
    ContactMailer.contact_us(
                              {name: 'garrett', email: 'garrettstott@gmail.com'},
                              'There is a bug',
                              'https://talkingcars.io there is a bug here'
                            )
  end
end
