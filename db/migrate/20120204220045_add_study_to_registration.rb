class AddStudyToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :study, :string

  end
end
