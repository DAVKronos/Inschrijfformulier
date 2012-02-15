class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :name
      t.date :birthdate
      t.references :sex
      t.references :club
      t.string :licensenumber
      t.references :college
      t.references :study
      t.string :studentnumber
      t.string :email
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
      t.string    :crypted_password,    :null => false
      t.string    :password_salt,       :null => false                
      t.string    :persistence_token,   :null => false                
      t.string    :single_access_token, :null => false               
      t.string    :perishable_token,    :null => false                
      

      t.timestamps
    end
    add_index :registrations, :sex_id
    add_index :registrations, :club_id
    add_index :registrations, :college_id
    add_index :registrations, :study_id
  end
end
