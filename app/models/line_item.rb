class LineItem < ActiveRecord::Base
  scope :select_product, -> do
    joins(:product).select "line_items.*", "products.name", "products.image"
  end
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true,
    numericality: {only_integer: true, greater_than: 0}
  validate :total_quantity_product

  def set_price
    self.price = self.product.price
  end

  private
  def total_quantity_product
    if self.quantity > self.product.total
      errors.add "product",
        I18n.t("messages.validates_total")
    end
  end
end
