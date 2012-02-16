class AddStudyToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :study, :string

  end
end
