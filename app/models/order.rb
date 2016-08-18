class Order < ActiveRecord::Base
  enum status: [:new_order, :pendding, :success, :cancle]

  scope :get_user, -> {joins(:user).select "orders.*", "users.name"}

  scope :group_by_date, -> {group "DATE(created_at)"}

  belongs_to :user
  has_many :line_items, dependent: :destroy

  before_create :set_order_status
  before_save :update_subtotal, :update_number_items

  def subtotal
    self.line_items.collect do |item|
      item.valid? ? (item.quantity * item.price) : 0
    end.sum
  end
  def order_number_items
    self.line_items.size
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

  private
  def set_order_status
    self.status = :new_order
  end

  def update_subtotal
    self.total_price = subtotal
  end

  def update_number_items
    self.number_items = order_number_items
  end
end
