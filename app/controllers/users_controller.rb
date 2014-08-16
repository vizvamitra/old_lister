class UsersController < ApplicationController
  def register
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "#{@user.login.capitalize} зарегистрирован"
    else
      render :register
    end
  rescue ActionController::ParameterMissing
    @user = User.new
    render :register
  end

  private

  def user_params
    params.require(:user).permit(:login, :password, :password_confirmation)
  end
end
