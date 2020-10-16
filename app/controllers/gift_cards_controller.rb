class GiftCardsController < ApplicationController
    before_action :require_login
    before_action :current_user
    helper_method :all_valid_cards
    helper_method :valid_sent_cards
    helper_method :valid_received_cards
    before_action :authenticate_user, except: [:public_show]

    def index
        render 'gift_cards/index'
    end

    def show
        @card = current_user.sent_gift_cards.last
        render 'gift_cards/show'
    end

    def public_show
        @card = GiftCard.find_by_id(params[:id])
    end

    def new
        @card = GiftCard.new
        render 'gift_cards/new'
    end


    def create
        @card = GiftCard.new(gift_card_params)
        @card.assign_attributes(sender: current_user, code: generate_code)
        if @card.recipient = User.find_by_email(params[:gift_card][:recipient])
            if @card.save
                flash[:notice] = ["Card successfully sent"]
                redirect_to user_gift_card_path(current_user.id, @card.id)
            else
                #i don't think this scenario will happen
                flash[:alert] = ["There was a problem with your request"]
                render 'gift_cards/new'
            end
        else
            @card.recipient = User.create(password: generate_code, email: params[:gift_card][:recipient])
            @card.update(sender: current_user, code: generate_code)
            flash[:notice] = ["We couldn't find your friend in our system, so we've invited them to our platform.", "Card successfully created."]
            redirect_to user_gift_card_path(current_user.id, @card.id)
        end
    end

    def sent
        render 'gift_cards/sent'
    end

        private

        def gift_card_params
            params.require(:gift_card).permit(:store_id, :dollar_value, :message)
        end

        def generate_code
            SecureRandom.alphanumeric
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