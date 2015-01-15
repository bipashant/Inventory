class AddQualityToProducts < ActiveRecord::Migration
  def change
    add_column :products, :quality, :string
  end
end
