class User < ApplicationRecord
    has_secure_password

    has_many :sent_gift_cards, class_name: "GiftCard", foreign_key: "sender_id"
    has_many :received_gift_cards, class_name: "GiftCard", foreign_key: "recipient_id"

    scope :admins, -> {where(admin:true)}

    def stores
        giftcards = (self.sent_gift_cards + self.received_gift_cards).uniq
        stores = giftcards.collect {|s| s.store_id}.compact.uniq
        Store.find(stores)
    end

end
