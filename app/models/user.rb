class User < ApplicationRecord
    has_many :sent_gift_cards, class_name: "GiftCard", foreign_key: "sender_id"
    has_many :received_gift_cards, class_name: "GiftCard", foreign_key: "recipient_id"

    scope :admins, -> {where(admin:true)}

    has_secure_password
    validates :password, length: { in: 6..20 }

    validates :username, uniqueness: true, allow_nil: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

    def stores
        giftcards = (self.sent_gift_cards + self.received_gift_cards).uniq
        stores = giftcards.collect {|s| s.store_id}.compact.uniq
        Store.find(stores)
    end

    def gift_cards
        GiftCard.where('sender_id = ? or recipient_id = ?', self.id, self.id)
    end

    def self.find_by_username_or_email(user_arg)
        self.where('username = ? or email = ?', user_arg, user_arg).first
    end

    def recent_activity(num_days)
        gift_cards.where("updated_at > ?", num_days.days.ago.localtime)
    end

end
