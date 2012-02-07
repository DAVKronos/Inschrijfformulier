class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.references :category

      t.timestamps
    end
    add_index :events, :category_id
  end
end
