class User < ApplicationRecord
    has_secure_password

    has_many :sent_gift_cards, class_name: "GiftCard", foreign_key: "sender_id"
    has_many :received_gift_cards, class_name: "GiftCard", foreign_key: "recipient_id"
end
