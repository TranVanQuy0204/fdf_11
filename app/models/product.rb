class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  scope :order_by_created_at, -> {order(created_at: :desc)}

  belongs_to :category
  has_many :line_items
  has_many :comments

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
