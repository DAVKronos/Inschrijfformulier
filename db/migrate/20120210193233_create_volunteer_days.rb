class CreateVolunteerDays < ActiveRecord::Migration
  def change
    create_table :volunteer_days do |t|
      t.references :day
      t.references :registration

      t.timestamps
    end
    add_index :volunteer_days, :day_id
    add_index :volunteer_days, :registration_id
  end
end
