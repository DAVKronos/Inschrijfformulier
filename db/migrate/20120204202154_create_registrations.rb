class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :name
      t.string :birthdate
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

      t.timestamps
    end
    add_index :registrations, :sex_id
    add_index :registrations, :club_id
    add_index :registrations, :college_id
    add_index :registrations, :study_id
  end
end
