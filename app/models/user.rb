class User < ApplicationRecord
    has_secure_password
    validates :password, length: { minimum: 6, maximum: 20 }

    validates :username, presence: true
    validates :username, uniqueness: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

    has_many :sent_gift_cards, class_name: "GiftCard", foreign_key: "sender_id"
    has_many :received_gift_cards, class_name: "GiftCard", foreign_key: "recipient_id"

    scope :admins, -> {where(admin:true)}

    def stores
        giftcards = (self.sent_gift_cards + self.received_gift_cards).uniq
        stores = giftcards.collect {|s| s.store_id}.compact.uniq
        Store.find(stores)
    end

end
