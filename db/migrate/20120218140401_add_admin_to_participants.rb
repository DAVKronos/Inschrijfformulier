class AddAdminToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :admin, :boolean

  end
end
