class Order < ActiveRecord::Base
  enum status: [:new_order, :pendding, :in_progress, :finish, :cancel]

  belongs_to :user
  has_many :line_items, dependent: :destroy

  before_create :set_order_status
  before_save :update_subtotal, :update_number_items

  def subtotal
    self.line_items
      .collect{|item| item.valid? ? (item.quantity * item.price) : 0}.sum
  end

  def order_number_items
    self.line_items.size
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
