require 'rails_helper'

RSpec.describe 'Inventories', type: :system do
  describe 'index page' do
    before(:each) do
      user = User.create(name: 'Ahmad', email: 'test@example.com', password: 'password')
      Inventory.create(description: 'It is an inventory', user: user)
      Inventory.create(description: 'It is an inventory', user: user)
      Inventory.create(description: 'It is an inventory', user: user)
      sign_in user
      visit inventories_path
    end

    let(:inventories) { Inventory.all }

    it 'shows the correct description' do
    inventories.each do |inventory|
        expect(page).to have_content(inventory.description)
      end
    end

    it 'displays a link to add an inventory' do
        expect(page).to have_link('Add New Inventory', href: new_inventory_path)
      end
  end
end
