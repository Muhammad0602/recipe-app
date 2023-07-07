class Inventory < ApplicationRecord
  belongs_to :user
  has_many :inventory_foods
  attribute :description, :string

  validates :name, presence: true
  validates :description, presence: true
end
