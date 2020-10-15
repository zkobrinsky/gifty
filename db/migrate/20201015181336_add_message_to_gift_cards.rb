class AddMessageToGiftCards < ActiveRecord::Migration[6.0]
  def change
    add_column :gift_cards, :message, :string
  end
end
