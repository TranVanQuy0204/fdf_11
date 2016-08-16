class LineItem < ActiveRecord::Base
  scope :select_product, -> do
    joins(:product).select "line_items.*", "products.name", "products.image"
  end

  belongs_to :product
  belongs_to :order
end
