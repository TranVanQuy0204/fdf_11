class Order < ActiveRecord::Base
  enum status: [:new_order, :pendding, :success, :cancel]

  scope :with_user, -> {joins(:user).select "orders.*", "users.name"}

  belongs_to :user
  has_many :line_items, dependent: :destroy

  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    self.line_items.collect do |item|
      item.valid? ? (item.quantity * item.price) : 0
    end.sum
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
end
