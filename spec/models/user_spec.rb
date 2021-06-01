require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'returns valid if all the fields are properly filled out' do
      @user = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
      expect(@user).to be_valid
    end

    # validates :password, presence: true
    it 'does not return valid if the password is empty' do
      @user = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: nil, password_confirmation: nil
      expect(@user).to_not be_valid
    end
    
    # validates :password, presence: true and matches password confirmation
    it 'does not return valid if the password and password confirmation do not match' do
      @user = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'iloveloki'
      expect(@user).to_not be_valid
    end

    # validates :password, presence: true and matches password confirmation
    it 'does not return valid if the password length is less than 6 characters' do
      @user = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'loki', password_confirmation: 'loki'
      expect(@user).to_not be_valid
    end

    # validates :email
    it 'does not return valid if the email is empty' do
      @user = User.create first_name: 'Thor', last_name: 'Odinson', email: nil, password: 'mjolnir', password_confirmation: 'mjolnir'
      expect(@user).to_not be_valid
    end

    # validates :email, presence: true uniqueness: true
    it 'does not return valid if the email is not unique' do
      @userOne = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
      @userTwo = User.create first_name: 'Loki', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
      expect(@userTwo).to_not be_valid
    end
    
    # validates :email, presence: true uniqueness: { case_sensitive: false }
    it 'does not return valid if the email is not unique, even if case is different' do
      @userOne = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
      @userTwo = User.create first_name: 'Loki', last_name: 'Odinson', email: 'THOR@ASGARDNET.COM', password: 'mjolnir', password_confirmation: 'mjolnir'
      expect(@userTwo).to_not be_valid
    end

    # validates :first_name, presence: true
    it 'does not return valid if the first name is empty' do
      @user = User.create first_name: nil, last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
      expect(@user).to_not be_valid
    end

    # validates :last_name, presence: true
    it 'does not return valid if the last name is empty' do
      @user = User.create first_name: 'Thor', last_name: nil, email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
      expect(@user).to_not be_valid
    end

    describe '.authenticate_with_credentials' do
      it 'should authenticate the user if the email and password are valid' do
        @user = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
        authenticated_user = User.authenticate_with_credentials('thor@asgardnet.com', 'mjolnir')
        expect(authenticated_user).to eq(@user)
      end
 
      it 'should authenticate the user if the email has spaces before or after it' do
        @user = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
        authenticated_user = User.authenticate_with_credentials('  thor@asgardnet.com  ', 'mjolnir')
        expect(authenticated_user).to eq(@user)
      end
      
      it 'should authenticate the user if the email has spaces anywhere in the email' do
        @user = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
        authenticated_user = User.authenticate_with_credentials('  t hor@as gar dnet.com  ', 'mjolnir')
        expect(authenticated_user).to eq(@user)
      end
      
      it 'should authenticate the user if the email has the wrong case in it' do
        @user = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
        authenticated_user = User.authenticate_with_credentials('tHor@AsgardNet.com', 'mjolnir')
        expect(authenticated_user).to eq(@user)
      end

      it 'should authenticate the user if the email has the wrong case in it and has spaces anywhere in it' do
        @user = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
        authenticated_user = User.authenticate_with_credentials('      tHo r@ Asgard Net   .com       ', 'mjolnir')
        expect(authenticated_user).to eq(@user)
      end

      
    end
  end
end
