class Order < ActiveRecord::Base
  enum status: [:new_order, :pendding, :success, :cancle]

  scope :select_user, -> do
    joins(:user).select "orders.*", "users.name"
  end

  belongs_to :user
  has_many :line_items, dependent: :destroy

  def self.to_csv options = {}
    CSV.generate options do |csv|
      csv << column_names
      all.each do |object|
        csv << object.attributes.values_at(*column_names)
      end
    end
  end
end
