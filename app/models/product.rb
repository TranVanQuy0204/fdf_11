class Product < ActiveRecord::Base
  belongs_to :category
  has_many :line_items
  has_many :comments

  validates :name, presence: true, length: {minimum: 1}
  validates :description, length: {maximum: 255}
  validates :total, presence: true,
    numericality: {only_integer: true, greater_than: 0}
  validates :price, presence: true,
    numericality: {only_integer: true, greater_than: 0}

  def self.to_csv options = {}
    CSV.generate options do |csv|
      csv << column_names
      all.each do |object|
        csv << object.attributes.values_at(*column_names)
      end
    end
  end
end
