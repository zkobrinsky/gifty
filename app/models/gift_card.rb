class GiftCard < ApplicationRecord
    belongs_to :sender, class_name: "User", foreign_key: "sender_id"
    belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"
    belongs_to :store

    # def users
    #     [self.recipient, self.sender]
    # end

end
