class GiftCardsController < ApplicationController
    before_action :require_login
    before_action :current_user

    def index
        # current_user
        # byebug
        render 'giftcards/index'
    end

    def show

    end

    def new

    end

    def create

    end

    def sent

    end

    def received

    end

end