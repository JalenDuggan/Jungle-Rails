require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validation' do

    before(:all) do
      ActiveRecord::Base.subclasses.each(&:delete_all)
    end

    it 'GEEN if password and password_confirmation is equal' do
      user = User.new(name: "Jalen Duhhan", email: "jalen1234@gmail.com", password: "1234", password_confirmation: "1234")
      user.save
      expect(user).to be_a User
    end

    it "RED if password and password_confirmation doesnt equal" do
      user = User.new(name: "Jalen Duhhan", email: "jalen1234@gmail.com", password: "1234", password_confirmation: "1ett")
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "RED if email and name is not given" do
      user = User.new(name: nil , email: "jalen1234@gmail.com", password: "1234", password_confirmation: "1234")
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)

      user = User.new(name: "Jalen Duhhan", email: nil, password: "1234", password_confirmation: "1234")
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "RED if email is all caps" do
      user = User.new(name: "Jalen Duhhan", email: "JALEN@GMAIL.COM", password: "1234", password_confirmation: "1234")
      user.save

      user_with_same_email =  User.new(name: "Duggan", email: "jalen1234@gmail.com", password: "1234", password_confirmation: "1234")
      expect { user_with_same_email.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "RED if password is < 3 characters or < 16 characters" do
      user = User.new(name: nil , email: "jalen1234@gmail.com", password: "12", password_confirmation: "12")
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)

      user = User.new(name: "Jalen Duhhan", email: "jalen1@gmail.com", password: "100713924jalenduggan", password_confirmation: "100713924jalenduggan")
      user.save
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

  end

  describe '.authenticate_with_credentials' do

    before(:all) do
      ActiveRecord::Base.subclasses.each(&:delete_all)
      user = User.new(name: "Jalen Duhhan", email: "jalen1234@gmail.com", password: "1234", password_confirmation: "1234")
      user.save!
    end

    it "returns user if the email is in a typed in a different case" do
      auth_user = User.authenticate_with_credentials(" 1234@gmail.com ", "1234")
      expect(auth_user).to be_a User
      auth_user = User.authenticate_with_credentials("1234@gmail.com ", "1234")
      expect(auth_user).to be_a User
    end

    it "should return user if the emails contains padding of spaces before or after the address" do
      auth_user = User.authenticate_with_credentials("  1234@gmail.com", "1234")
      expect(auth_user).to be_a User
      auth_user = User.authenticate_with_credentials("  1234@gmail.com   ", "1234")
      expect(auth_user).to be_a User
    end

    it "should return user if the user exists and the password is correct" do
      auth_user = User.authenticate_with_credentials("jalen1234@gmail.com", "1234")
      expect(auth_user).to be_a User

      auth_user = User.authenticate_with_credentials("hey@gmail.com", "12345")
      expect(auth_user).to be_nil

      auth_user = User.authenticate_with_credentials("1234@gmail.com", "123456")
      expect(auth_user).to be_nil
    end
    
  end
end 