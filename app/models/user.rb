class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable
  has_many :orders, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggestions, class_name: Suggest.name, dependent: :destroy

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_initialize
        .tap do |user|
        registered_user = User.where(email: auth.info.email).first
        return registered_user if registered_user
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name unless auth.info.name.nil?
        user.oauth_token = auth.credentials.token
        if auth.info.email.nil?
          email = "#{auth.uid}@#{auth.provider}.com"
        else
          email = auth.info.email
        end
        user.email = email
        user.password = Devise.friendly_token[0,20]
        user.save!
      end
    end
  end
end
