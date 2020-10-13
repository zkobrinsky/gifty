class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/welcome'
    else
      flash[:alert] = @user.errors.full_messages
      render 'users/new'
    end
  end

    private

      def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :email)
      end
end
