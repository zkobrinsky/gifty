class UsersController < ApplicationController
  def new
    # byebug
    @user = User.new
  end

  def create
    byebug
    @user = User.new(user_params)
    if @user.authenticate(params[:user][:password_confirmation])
      params[:user].delete :password_confirmation
      if @user.save
        session[:user_id] = @user.id
        redirect_to '/welcome'
      else
        #redirect and raise error for password confirmation
      end
    else
    #   #do something else
    end
  end

    private

      def user_params
        params.require(:user).permit(:username, :password, :email)
      end
end
