class CreateEventParticipations < ActiveRecord::Migration
  def change
    create_table :event_participations do |t|
      t.references :event
      t.references :registration

      t.timestamps
    end
    add_index :event_participations, :event_id
    add_index :event_participations, :registration_id
  end
end
