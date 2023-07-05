class CreateDiscount < ActiveRecord::Migration[7.1]
  def change
    create_table :discounts do |t|
      t.string :condition
      t.belongs_to :product, foreign_key: true
      t.timestamps
    end
  end
end
