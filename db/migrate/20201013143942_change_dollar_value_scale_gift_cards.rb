class ChangeDollarValueScaleGiftCards < ActiveRecord::Migration[6.0]
  def change
    change_column :gift_cards, :dollar_value, :decimal, :precision => 9, :scale => 2
  end
end
