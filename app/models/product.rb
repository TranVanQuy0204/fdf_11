class Product < ActiveRecord::Base
  scope :sort, -> {order(created_at: :desc)}

  belongs_to :category
  has_many :line_items
  has_many :comments
end
