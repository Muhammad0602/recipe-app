require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before(:each) do
    @user = User.create(name: 'Davian', email: 'davian@davian.com', encrypted_password: '123456')
    @food = Food.new(name: 'mango', measurement_unit: 'lbs', price: 1)
    @recipe = Recipe.new(user: @user, name: 'Lasagna', description: 'Steps to make great Lasagna',
                         preparation_time: 60, cooking_time: 45, public: true)
    @recipe_food = RecipeFood.new(quantity: 1, recipe: @recipe, food: @food)
  end

  context 'Validation tests' do
    it 'Validation should be successful' do
      expect(@recipe_food).to be_valid
    end

    it 'RecipeFood should have a quantity' do
      expect(@recipe_food.quantity).to be_present
    end

    it 'RecipeFood should have a recipe' do
      expect(@recipe_food.recipe).to be_present
    end

    it 'RecipeFood should have a food' do
      expect(@recipe_food.food).to be_present
    end

    it 'RecipeFood quantity should be greater than 0' do
      expect(@recipe_food.quantity).to be >= 0
    end

    it 'RecipeFood quantity should be numeric' do
      expect(@recipe_food.quantity).to be_a_kind_of(Numeric)
    end

    it 'RecipeFood recipe name should be' do
      expect(@recipe_food.recipe.name).to eq('Lasagna')
    end

    it 'RecipeFood food name should be' do
      expect(@recipe_food.food.name).to eq('mango')
    end
  end

  context 'Association tests' do
    it 'RecipeFood should belong to a recipe' do
      @recipe_food = RecipeFood.reflect_on_association(:recipe)
      expect(@recipe_food.macro).to eq(:belongs_to)
    end

    it 'RecipeFood should belong to a food' do
      @recipe_food = RecipeFood.reflect_on_association(:food)
      expect(@recipe_food.macro).to eq(:belongs_to)
    end
  end
end
