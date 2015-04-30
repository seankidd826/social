class User < ActiveRecord::Base

  has_many :photos
  has_many :comments

  has_many :likes
  has_many :like_photos, :through => :likes, :source => "photo"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]

      user.name = auth.info.name   # assuming the user model has a name
      user.fb_image = auth.info.image # assuming the user model has an image
    end
  end

end
