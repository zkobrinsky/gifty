class AddImageUrlToStores < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :image_url, :string
  end
end
