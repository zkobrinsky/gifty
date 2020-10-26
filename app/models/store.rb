class Store < ApplicationRecord
    has_many :gift_cards

    def users
        senders = self.gift_cards.pluck(:sender_id)
        recipients = self.gift_cards.pluck(:recipient_id)
        User.find((recipients+senders).uniq)
    end

    def senders
        User.find(self.gift_cards.pluck(:sender_id))
    end

    def recipients
        User.find(self.gift_cards.pluck(:recipient_id))
    end
end

