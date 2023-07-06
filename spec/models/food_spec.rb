require 'rails_helper'

RSpec.describe Food, type: :model do
  subject { Food.create(name: 'Osh') }

  describe 'validations' do
    it 'the name should be present' do
      expect(subject).to be_valid
    end

    it 'should be not valid when the name is nil' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end
end
