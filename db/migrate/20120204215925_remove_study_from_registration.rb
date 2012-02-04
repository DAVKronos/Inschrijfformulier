class RemoveStudyFromRegistration < ActiveRecord::Migration
  def up
    remove_column :registrations, :study_id
  end

  def down
    add_column :registrations, :study, :references
    add_index :registrations, :study_id
  end
end
