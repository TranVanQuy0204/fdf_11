class Activity < ActiveRecord::Base
  # enum action_type: [:order, :register, :cancel, :suggest, :rate]

  belongs_to :user

  validates :user_id, presence: true
end
