class CreateRolesRegistrations < ActiveRecord::Migration
  def change
    create_table "roles", :force => true do |t|
       t.string   :name,              :limit => 40
       t.string   :authorizable_type, :limit => 40
       t.integer  :authorizable_id
       t.timestamps
     end
     
     create_table "roles_registrations", :id => false, :force => true do |t|
         t.references  :registration
         t.references  :role
         t.timestamps
       end
  end
end
