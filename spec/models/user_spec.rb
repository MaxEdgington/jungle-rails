require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should not be valid without a password' do
      user = User.new(email: 'test@test.com')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    
    it 'should not be valid with a short password' do
      user = User.new(email: 'test@test.com', password: 'short')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    
    it 'should not be valid without email' do
      user = User.new(password: 'password')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    
    it 'should not be valid without a unique email' do
      User.create(email: 'test@test.com', password: 'password')
      user = User.new(email: 'TEST@test.com', password: 'password')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include('Email has already been taken')
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate with correct credentials' do
      user = User.create(email: 'test@test.com', password: 'password')
      authenticated_user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should authenticate with spaces around email' do
      user = User.create(email: 'test@test.com', password: 'password')
      authenticated_user = User.authenticate_with_credentials(' test@test.com ', 'password')
      expect(authenticated_user).to eq(user)
    end
    
    it 'should authenticate with wrong case for email' do
      user = User.create(email: 'test@test.com', password: 'password')
      authenticated_user = User.authenticate_with_credentials('TEST@test.com', 'password')
      expect(authenticated_user).to eq(user)
    end
    
    it 'should not authenticate with incorrect password' do
      user = User.create(email: 'test@test.com', password: 'password')
      authenticated_user = User.authenticate_with_credentials('test@test.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end
  end
end