class Category < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  validates :name, presence: true, length: {minimum: 1}
  has_many :products
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  class << self
    def to_csv options = {}
      CSV.generate options do |csv|
        csv << column_names
        all.each do |object|
          csv << object.attributes.values_at(*column_names)
        end
      end
    end
  end
end
