require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET :register" do

    before(:each){ get :register }

    it "assigns @user" do
      expect(assigns(:user)).to be_a_new User
    end

    it 'renders template :register' do
      expect( response ).to render_template :register
    end

  end


  describe "POST :check_login" do
    render_views

    it 'searches for user with given login' do
      expect( User ).to receive(:find_by).with(login: 'login')
      post :check_login, login: 'login', jormat: :js
    end

    it 'downcases login before search' do
      expect( User ).to receive(:find_by).with(login: 'login')
      post :check_login, login: 'LoGIn', jormat: :js
    end

    context 'user exists' do
      it 'renders error message' do
        create(:user, login: 'login')
        post :check_login, login: 'login', jormat: :js
        expect( response.body ).to eq 'Логин занят'
      end
    end

    context "user doesn't exist" do
      it 'renders nothing' do
        post :check_login, login: 'login', jormat: :js
        expect( response.body ).to eq ''
      end
    end
  end


  describe "POST :create" do
    
    context 'success' do
      let(:params){ {login: 'login', password: 'password', password_confirmation: 'password'} }

      before(:each) do
        User.delete_all
        post :create, user: params
      end

      it 'creates new user' do
        expect( User.first.login ).to eq 'login'
      end

      it 'redirects to main page' do
        expect( response ).to redirect_to '/'
      end

      it 'sets success notice' do
        expect( flash[:notice] ).to eq 'Пользователь Login создан успешно'
      end

      it 'initializes session' do
        expect( session[:user_id] ).to eq assigns(:user).id
      end
    end

    context 'failure' do
      context "'user' parameter is missing" do
        before(:each){ post :create }

        it "assigns @user" do
          expect(assigns(:user)).to be_a_new User
        end

        it 'renders action :register' do
          expect( response ).to render_template :register
        end
      end

      context 'params are not valid' do
        it 'renders action :register' do
          post :create, user: {password: 'short', password_confirmation: 'short'}
          expect( response ).to render_template :register
        end
      end
    end

  end

end
