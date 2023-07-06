class Inventory < ApplicationRecord
  belongs_to :user
  has_many :inventory_foods
  attribute :description, :string
end
