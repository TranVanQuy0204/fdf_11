class User < ActiveRecord::Base
  include PublicActivity::Model
  # tracked owner_id: Proc.new{ |controller, model| controller.current_user }
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable
  enum role: [:admin, :user]

  has_many :orders, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggestions, class_name: Suggest.name, dependent: :destroy

  def self.to_csv options = {}
    CSV.generate options do |csv|
      csv << column_names
      all.each do |object|
        csv << object.attributes.values_at(*column_names)
      end
    end
  end
end
