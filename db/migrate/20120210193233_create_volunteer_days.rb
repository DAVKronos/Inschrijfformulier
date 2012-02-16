class CreateVolunteerDays < ActiveRecord::Migration
  def change
    create_table :volunteer_days do |t|
      t.references :day
      t.references :entry

      t.timestamps
    end
    add_index :volunteer_days, :day_id
    add_index :volunteer_days, :entry_id
  end
end
