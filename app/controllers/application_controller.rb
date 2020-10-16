class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :logged_in?

    def current_user
        @user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    def authenticate_user
        if current_user.id == params[:id].to_i || current_user.id == params[:user_id].to_i
            return
        else
            redirect_to welcome_path
            flash[:alert] = ["Aren't you cheeky trying to edit someone else's account"]
        end
    end

    def log_in
        session[:user_id] = @user.id
    end

    def require_login
        unless current_user
            flash[:alert] = []
            flash[:alert] << "Please log in to access this page"
            redirect_to login_path
        end
    end
end
