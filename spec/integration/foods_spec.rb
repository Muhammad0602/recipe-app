require 'rails_helper'

RSpec.describe 'Foods', type: :system do
  describe 'index page' do
    before(:each) do
      Food.create(name: 'Osh', measurement_unit: 'grams', price: 4.99)
      Food.create(name: 'Qurutob', measurement_unit: 'grams', price: 8.99)
      Food.create(name: 'Shakarob', measurement_unit: 'grams', price: 7.99)
      user = User.create(email: 'test@example.com', password: 'password')
      sign_in user
      visit foods_path
    end

    let(:foods) { Food.all }

    it 'shows the right name' do
      foods.each do |food|
        expect(page).to have_content(food.name)
      end
    end

    it 'shows the correct unit' do
      foods.each do |food|
        expect(page).to have_content(food.measurement_unit)
      end
    end

    it 'shows the correct price' do
      foods.each do |food|
        expect(page).to have_content(food.price)
      end
    end
  end
end
