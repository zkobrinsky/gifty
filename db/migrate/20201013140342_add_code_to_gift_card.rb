class AddCodeToGiftCard < ActiveRecord::Migration[6.0]
  def change
    add_column :gift_cards, :code, :string
  end
end
