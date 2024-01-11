require 'rails_helper'

RSpec.describe User, type: :model do
    it "should not create a user without an email" do
        user = User.create(
            password: 'password',
            password_confirmation: 'password'
        )
        expect(user.errors[:email]).to_not be_empty
    end

    it "should not create a user without a password" do
        user = User.create(
            email: 'test@example.com',
            password_confirmation: 'password'
        )
        expect(user.errors[:password]).to_not be_empty
    end

    it "should not create a user without a password of at least 8 characters" do
        user = User.create(
            email: 'test@example.com',
            password: 'pass',
            password_confirmation: 'password'
        ) 
        expect(user.errors[:password]).to_not be_empty
    end

    it "should not create a user without a password confirmation" do
        user = User.create(
            email: 'test@example.com',
            password: 'password',
        ) 
        expect(user.errors[:password_confirmation]).to_not be_empty
    end

    it "should not allow users with duplicate emails" do
        User.create(
            email: 'test@example.com',
            password: 'password',
            password_confirmation: 'password'
        )
        user = User.create(
            email: 'test@example.com',
            password: 'password',
            password_confirmation: 'password'
        )
        expect(user.errors[:email]).to_not be_empty
    end

    it "should not allow password and password_confirmation to be different" do
        user = User.create(
            email: 'test@example.com',
            password: 'password',
            password_confirmation: 'passw0rd'
        )
        expect(user.errors[:password_confirmation]).to_not be_empty
    end
end
