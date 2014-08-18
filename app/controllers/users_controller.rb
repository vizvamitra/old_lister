class UsersController < ApplicationController
  def register
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id

      redirect_to root_path, notice: "Пользователь #{@user.login.capitalize} создан успешно"
    else
      render :register
    end
  end

  def check_login
    @user = User.find_by(login: params[:login].downcase)
    if @user
      render 'check_login', layout: false
    else
      render text: ''
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :password, :password_confirmation)
  rescue ActionController::ParameterMissing
    {login: '', password: '', password_confirmation: ''}
  end
end
