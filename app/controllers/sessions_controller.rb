class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    byebug
    if @user && @user.authenticate(params[:password])
       log_in
       redirect_to '/welcome'
    else
      @user.valid?
      flash[:alert] = @user.errors.full_messages
      redirect_to login_path
    end
 end

  def welcome
  end

  def destroy
    session.clear
    redirect_to '/welcome'
  end
end
