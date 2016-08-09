class User < ActiveRecord::Base
  # has_many :orders, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggestions, class_name: Suggest.name, dependent: :destroy

  def self.from_omniauth(auth)

    puts auth.info
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name unless auth.info.name.nil?
      user.oauth_token = auth.credentials.token
      user.email = auth.info.email unless auth.info.email.nil?
      user.save!
    end
  end
end
