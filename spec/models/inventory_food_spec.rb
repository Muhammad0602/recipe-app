require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  let(:user) { User.create(name: 'Ahmad', email: 'user@example.com', password: 'password') }
  let(:food) { Food.create(name: 'Osh') }
  let(:inventory) { Inventory.create(name: 'First', description: 'It is an inventory', user: user)}
  subject { InventoryFood.create(quantity: 10, inventory: inventory, food: food)}

  describe 'validations' do

    it 'should have a name' do
      expect(subject).to be_valid
    end

    it 'should not be valid without a quantity' do
      subject.quantity = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an inventory' do
      expect(subject.inventory).to eq(inventory)
    end

    it 'belongs to a food' do
      expect(subject.food).to eq(food)
    end
  end
end
