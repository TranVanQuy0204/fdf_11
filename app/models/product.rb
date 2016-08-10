class Product < ActiveRecord::Base

  scope :order_by_created_at, -> {order(created_at: :desc)}

  belongs_to :category
  has_many :line_items
  has_many :comments
end
