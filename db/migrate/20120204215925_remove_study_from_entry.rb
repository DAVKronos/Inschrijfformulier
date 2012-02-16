class RemoveStudyFromEntry < ActiveRecord::Migration
  def up
    remove_column :entries, :study_id
  end

  def down
    add_column :entries, :study, :references
    add_index :entries, :study_id
  end
end
