class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  scope :order_by_created_at, -> {order(created_at: :desc)}
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  belongs_to :category
  has_many :line_items
  has_many :comments
  validates :total, presence: true,
    numericality: {only_integer: true, greater_than: 0}
  validates :name, length: {minimum: 1}
  def update_quantity quantity
    self.total -= quantity
  end
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
