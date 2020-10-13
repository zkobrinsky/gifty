class AddDollarValueToGiftCard < ActiveRecord::Migration[6.0]
  def change
    add_column :gift_cards, :dollar_value, :decimal
  end
end
