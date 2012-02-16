class CreateEventParticipations < ActiveRecord::Migration
  def change
    create_table :event_participations do |t|
      t.references :event
      t.references :entry
      t.string :best_performance
      t.date :best_date
      t.string :best_location

      t.timestamps
    end
    add_index :event_participations, :event_id
    add_index :event_participations, :entry_id
  end
end
