class GiftCardsController < ApplicationController
    before_action :require_login
    before_action :current_user
    helper_method :all_valid_cards
    helper_method :valid_sent_cards
    helper_method :valid_received_cards

    def index
        # current_user
        # byebug
        render 'giftcards/index'
        # @cards = current_user.gift_cards.select {|g| g.dollar_value}
    end

    def show
        byebug
    end

    def new

    end

    def create

    end

    def sent
        render 'giftcards/sent'
    end

    def received

    end

        private

        def all_valid_cards
            if current_user
                current_user.gift_cards.select {|g| g.dollar_value}.select {|g| g.store != nil}
            end
        end

        def valid_sent_cards
            if current_user
                current_user.sent_gift_cards.select {|g| g.dollar_value}.select {|g| g.store != nil}
            end
        end

        def valid_received_cards
            if current_user
                current_user.received_gift_cards.select {|g| g.dollar_value}.select {|g| g.store != nil}
            end
        end

end