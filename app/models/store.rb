class Store < ApplicationRecord
    has_many :gift_cards

    def users
        giftcards = GiftCard.where(store_id: self.id)
        senders = giftcards.pluck(:sender_id)
        recipients = giftcards.pluck(:recipient_id)
        User.find((recipients+senders).uniq)
    end
end

