class SessionsController < ApplicationController

  def new
  end

  def create
    if auth
      omniauth_login
      log_in
      redirect_to welcome_path
    else
      if @user = User.find_by_username_or_email(params[:email])
        if @user && @user.authenticate(params[:password])
           log_in
           redirect_to welcome_path
        else
          flash[:alert] = ["Incorrect Password"]
          redirect_to login_path
        end
      else
        flash[:alert] = ["Could not find user '#{params[:email]}'."]
        redirect_to login_path
      end
    end
 end

  def welcome
  end

  def destroy
    session.clear
    redirect_to '/welcome'
  end

    private

      def make_password
        SecureRandom.alphanumeric
      end

      def auth
        request.env['omniauth.auth']
      end

      def omniauth_login
        @user = User.find_or_create_by(email: auth['info']['email'])
        @user.username = auth['info']['name'] if @user.username.blank?
        @user.password = make_password if @user.password.blank?
      end

    
end
