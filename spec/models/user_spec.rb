require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { User.new }

  it 'should have valid factory' do
    expect( build(:user) ).to be_valid
  end

  describe 'validations' do

    context 'login validations' do
      it 'validates presence of login' do
        expect( build(:user, login: '') ).not_to be_valid
      end

      it 'validates uniqueness of login' do
        create(:user, login: 'Username')
        expect( build(:user, login: 'Username') ).not_to be_valid
      end

      it 'validates length of login' do
        expect( build(:user, login: 'Us') ).not_to be_valid
        expect( build(:user, login: 'U'*21) ).not_to be_valid
      end

      it 'validates format of login' do
        expect( build(:user, login: 'U$er') ).not_to be_valid
        expect( build(:user, login: 'Юзер') ).not_to be_valid
        expect( build(:user, login: 'U-s+e-r') ).not_to be_valid
      end
    end

    context 'password validations' do
      it 'validates presence of password' do
        user = build(:user, password: '', password_confirmation: '')
        expect( user ).not_to be_valid
      end

      it 'validates confirmation of password' do
        user = build(:user, password: 'password', password_confirmation: 'drowssap')
        expect( user ).not_to be_valid
      end

      it 'validates length of password' do
        user = build(:user, password: 'short', password_confirmation: 'short')
        expect( user ).not_to be_valid
      end
    end

  end
end
