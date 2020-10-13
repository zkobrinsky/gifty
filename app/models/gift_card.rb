class GiftCard < ApplicationRecord
    belongs_to :sender, class_name: "User", foreign_key: "sender_id"
    belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"
    belongs_to :store

    scope :big_spender, -> {where("dollar_value >= ?", 1000)}

end
