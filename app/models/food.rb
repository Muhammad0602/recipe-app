class Food < ApplicationRecord
    validates :name, presence: true

    has_many :inventory_food
    has_many :recipe_food
end
