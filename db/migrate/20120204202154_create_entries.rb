class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.date :birthdate
      t.references :sex
      t.references :club
      t.string :licensenumber
      t.references :college
      t.references :study
      t.references :participant
      t.string :studentnumber
      t.string :banknumber
      t.string :bankAccountName
      t.string :bankLocation
      t.boolean :bankAuthorization
      t.boolean :meetRegulations
      t.boolean :zeusDatabase
      t.boolean :diner
      t.boolean :party
      t.string :shirtsize
      t.string :volunteerPreferences
      t.string :auth_hash     
      

      t.timestamps
    end
    add_index :entries, :sex_id
    add_index :entries, :club_id
    add_index :entries, :college_id
    add_index :entries, :study_id
  end
end
