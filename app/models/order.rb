class Order < ActiveRecord::Base
  enum status: [:new_order, :pendding, :in_progress, :finish, :cancle]

  belongs_to :user
  has_many :line_items, dependent: :destroy

  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    self.line_items
      .collect{|item| item.valid? ? (item.quantity * item.price) : 0}.sum
  end

  private
  def set_order_status
    self.status = :new_order
  end

  def update_subtotal
    self.total_price = subtotal
  end
end
