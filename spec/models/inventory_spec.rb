require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:user) { User.create(name: 'Ahmad', email: 'user@example.com', password: 'password') }
  subject { Inventory.create(name: 'First', description: 'It is an inventory', user:) }

  describe 'validations' do
    it 'should have a name' do
      expect(subject).to be_valid
    end

    it 'should not be valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'should not be valid without a description' do
      subject.description = nil
      expect(subject).not_to be_valid
    end
  end
end
