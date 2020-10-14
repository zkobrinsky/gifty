class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
         log_in
         redirect_to '/welcome'
      else
        # byebug
        flash[:alert] = []
        flash[:alert] << "Incorrect Password"
        redirect_to login_path
      end
    else
      flash[:alert] = []
      flash[:alert] << "Could not find user '#{params[:username]}'."
      redirect_to login_path
    end
 end

  def welcome
    current_user
  end

  def destroy
    session.clear
    redirect_to '/welcome'
  end
end
