require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'Muhammad') }

  describe 'validations' do
    it 'should have a name, email, and password' do
      subject.name = 'Ahmad'
      subject.email = 'ahmad@example.com'
      subject.password = 'password'
      expect(subject).to be_valid
    end

    it 'should not be valid without a name' do
      subject.name = nil
      subject.email = 'ahmad@example.com'
      subject.password = 'password'
      expect(subject).not_to be_valid
    end

    it 'should not be valid without an email' do
      subject.name = 'Ahmad'
      subject.email = nil
      subject.password = 'password'
      expect(subject).not_to be_valid
    end

    it 'should not be valid without a password' do
      subject.name = 'Ahmad'
      subject.email = 'ahmad@example.com'
      subject.password = nil
      expect(subject).not_to be_valid
    end
  end
end
