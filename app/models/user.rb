class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  validates_uniqueness_of :username
  validates_presence_of :username

  acts_as_messageable

  has_many :posts
  has_many :replies
  has_many :favorites
  has_many :vehicles

  def name
    self.username
  end

  def mailboxer_email(object)
    self.email
  end
end
