class Category < ActiveRecord::Base
  has_many :products, dependent: :destroy
  mount_uploader :image, ImageUploader

  validates :name, presence: true, length: {minimum: 6}
  validates :description, presence: true, length: {maximum: 255}
  def self.to_csv options = {}
    CSV.generate options do |csv|
      csv << column_names
      all.each do |object|
        csv << object.attributes.values_at(*column_names)
      end
    end
  end
end
