class GiftCardsController < ApplicationController
    before_action :require_login
    before_action :current_user
    helper_method :all_valid_cards
    helper_method :valid_sent_cards
    helper_method :valid_received_cards

    def index
        if authenticate_user
            render 'giftcards/index'
        else
            # byebug
        end
    end

    def show
        render 'giftcards/show'
    end

    def new
        @card = GiftCard.new
        render 'giftcards/new'
    end

    def create
        @card = GiftCard.new(gift_card_params)
        @card.recipient = User.find_by_username_or_email(params[:gift_card][:recipient], params[:gift_card][:recipient])
        @card.sender = current_user
        generate_code
        byebug
    end

    def sent
        render 'giftcards/sent'
    end

        private

        def gift_card_params
            params.require(:gift_card).permit(:store_id, :dollar_value)
        end

        def generate_code
            @card.code = SecureRandom.alphanumeric
        end

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