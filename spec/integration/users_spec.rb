require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'index page' do
    before(:each) do
      User.create(name: 'Ahmad')
      User.create(name: 'Sadam')
    end
    let(:users) { User.all }

    it 'shows the name of a user' do
      visit root_path
      users.each do |user|
        expect(page).to haev_content(user.name)
      end
    end
  end
end
