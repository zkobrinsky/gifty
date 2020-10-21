class UsersController < ApplicationController
  before_action :authenticate_user, except: [:new, :create, :new_from_gift_card, :create_from_gift_card]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in
      redirect_to '/welcome'
    else
      flash[:alert] = @user.errors.full_messages
      render 'users/new'
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    current_user.assign_attributes(user_params)
    if current_user.save
      redirect_to user_path
    else
      flash[:alert] = current_user.errors.full_messages
      render 'users/edit'
    end
  end

  def show
  end

  def new_from_gift_card
    @user = User.new
    if logged_in?
      redirect_to welcome_path
    end
  end

  def create_from_gift_card
    if logged_in?
      redirect_to welcome_path
    elsif @card = GiftCard.find_by_code(params[:user][:code])
      if @card.recipient.email == params[:user][:email]
        @user = @card.recipient
        @user.assign_attributes(user_params)
        if @user.save
          log_in
          redirect_to welcome_path
        else
          flash[:alert] = @user.errors.full_messages
          render invite_path
        end
      else
        flash[:alert] = ["The email you entered does not match the email associated with the Gift Card code."]
        redirect_to invite_path
      end
    else
      flash[:alert] = ["Gift Card not found."]
      redirect_to invite_path
    end
  end

  

    private

      def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :email)
      end

end
