class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.references :sex

      t.timestamps
    end
    add_index :events, :sex_id
  end
end
