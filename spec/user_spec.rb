require 'rails_helper'

RSpec.describe Product, type: :model do

  it 'should work' do
    expect('it').to be_truthy
  end

  describe 'Validations' do
    # validation tests/examples here
    it 'should not save user due to unmatched passwords' do
      @user = User.new({
        name:  'Payal',
        email: 'payal@gmail.com',
        password: '123',
        password_confirmation: '1234'
      })

      expect(@user.save).to be false
    end

    it 'should not save user due to missing password' do
      @user = User.new({
        name:  'payal',
        email: 'payal@gmail.com',
        password: nil,
        password_confirmation: '1234'
      })
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end


    it 'should not save user due to email already exists' do
      @user1 = User.new({
        name:  'Payal',
        email: 'TEST@TEST.com',
        password: '123',
        password_confirmation: '123'
      })
      expect(@user1.save).to be true
      @user2 = User.new({
        name:  'Payal',
        email: 'test@test.COM',
        password: '1234',
        password_confirmation: '1234'
      })
      expect(@user2.save).to be false
    end

    it 'should not save user due password length' do
      @user = User.new({
        name:  'payal',
        email: 'payal@gmail.com',
        password: '12',
        password_confirmation: '12'
      })
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end

    describe 'authenticate_with_credentials' do

      it 'should return an instance of the user if authenticated' do

        @user = User.new({
          name:  'payal',
          email: 'payal@gmail.com',
          password: '123',
          password_confirmation: '123'
        })
        @user.save
        @authenticated_user = User.authenticate_with_credentials('payal@gmail.com', '123')

        expect(@authenticated_user).to be_present

      end

      it 'should not return an instance of the user if authentication fails' do

        @user = User.new({
          name:  'payal',
          email: 'payal@gmail.com',
          password: '1233',
          password_confirmation: '1233'
        })
        @user.save
        @authenticated_user = User.authenticate_with_credentials('payal@gmail.com', 'wrong password')

        expect(@authenticated_user).to be_nil

      end

      it 'should return an instance of the user even if there are extra spaces in the email' do

        @user = User.new({
          name:  'payal',
          email: 'payal@gmail.com',
          password: '123',
          password_confirmation: '123'
        })
        @user.save
        @authenticated_user = User.authenticate_with_credentials(' payal@gmail.com ', '123')

        expect(@authenticated_user).to be_present

      end

      it 'should return an instance of the user even if the wrong case is used for their email' do

        @user = User.new({
          name:  'payal',
          email: 'payal@gmail.com',
          password: '123',
          password_confirmation: '123'
        })
        @user.save
        @authenticated_user = User.authenticate_with_credentials(' payal@gmail.COM ', '123')

        expect(@authenticated_user).to be_present
      end

    end

  end
end