class UsersController < ApplicationController
  def new
    # byebug
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # byebug
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/welcome'
    else
      # byebug
      flash[:alert] = @user.errors.full_messages
      render 'users/new'
    end
  end

    private

      def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :email)
      end
end
