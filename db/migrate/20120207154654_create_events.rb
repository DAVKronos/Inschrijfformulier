class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.references :sex
      t.boolean :time_format

      t.timestamps
    end
    add_index :events, :sex_id
  end
end
