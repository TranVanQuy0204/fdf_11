class Order < ActiveRecord::Base
  enum status: [:new_order, :pendding, :success, :cancel]

  scope :with_user, -> {joins(:user).select "orders.*", "users.name"}
  scope :group_by_date, -> {group "DATE(created_at)"}
  scope :with_new_order, -> (status = 0){where("status = ?","#{status}")}
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  belongs_to :user
  has_many :line_items, dependent: :destroy

  before_create :set_order_status, :set_code
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

  def set_code
    last_id = Order.last.nil? ? 0 : Order.last.id
    self.code = (10000 + last_id +1).to_s
  end
end
