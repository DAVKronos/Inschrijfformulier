class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :participant
      t.string :provider
      t.string :uid

      t.timestamps
    end
    add_index :authentications, :participant_id
  end
end
