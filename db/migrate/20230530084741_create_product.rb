class CreateProduct < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
