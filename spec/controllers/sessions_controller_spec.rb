require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "POST 'login'" do
    before(:each){ create(:user, login: 'username') }

    it 'searches for user with given login'
    it 'tries to authenticate with given password'
    it 'redirects to home page'

    context 'success' do
      it 'sets session user_id variable'
    end

    context 'failure' do
      
    end

  end

  describe "GET 'logout'" do
    it "clears session user info"
    it 'redirects to home page'
  end

end
