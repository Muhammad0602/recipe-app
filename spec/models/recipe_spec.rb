require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:each) do
    @user = User.create(name: 'Davian', email: 'davian@gmail.com', encrypted_password: '1233445567')
    @food = Food.new(name: 'apple', measurement_unit: 'lbs', price: 1)
    @recipe = Recipe.new(user: @user, name: 'Rice and peas', description: 'Steps to make great rice and peas',
                         preparation_time: 60, cooking_time: 45, public: true)
    @recipe_food = RecipeFood.new(quantity: 1, recipe: @recipe, food: @food)
  end

  context 'Validation tests' do
    it 'Validation should be successful' do
      expect(@recipe).to be_valid
    end

    it 'Recipe should have a name' do
      expect(@recipe.name).to be_present
    end

    it 'Recipe should have a description' do
      expect(@recipe.description).to be_present
    end

    it 'Recipe should have a preparation time' do
      expect(@recipe.preparation_time).to be >= 0
    end

    it 'Recipe should have a cooking time' do
      expect(@recipe.cooking_time).to be >= 0
    end

    it 'Recipe preparation time should be numeric' do
      expect(@recipe.preparation_time).to be_a_kind_of(Numeric)
    end

    it 'Recipe public should be boolean' do
      expect(@recipe.public).to be_a(TrueClass).or be_a(FalseClass)
    end

    it 'Recipe cooking time should be numeric' do
      expect(@recipe.cooking_time).to be_a_kind_of(Numeric)
    end

    it 'Should have a valid quantity' do
      expect(@recipe.description).to eq('Steps to make great rice and peas')
    end

    it 'Recipe should have a user' do
      expect(@recipe.user).to be_present
    end
  end

  context 'Association tests' do
    it 'Recipe should belong to a user' do
      @recipe = Recipe.reflect_on_association(:user)
      expect(@recipe.macro).to eq(:belongs_to)
    end

    it 'Recipe should have many recipes' do
      @recipe = Recipe.reflect_on_association(:recipe_foods)
      expect(@recipe.macro).to eq(:has_many)
    end
  end
end
