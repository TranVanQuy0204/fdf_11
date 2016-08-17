class Category < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  validates :name, presence: true, length: {minimum: 1}
  validates :description, length: {maximum: 255}

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
