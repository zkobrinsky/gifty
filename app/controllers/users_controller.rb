class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def new_from_gift_card
    @card = GiftCard.new
    @user = User.new
  end

  def create_from_gift_card
    byebug
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in
      redirect_to '/welcome'
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

    private

      def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :email)
      end
end
