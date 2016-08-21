class Comment < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
end
