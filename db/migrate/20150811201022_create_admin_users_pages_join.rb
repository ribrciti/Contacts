class CreateAdminUsersPagesJoin < ActiveRecord::Migration
  def change
    create_table :admin_users_pages , :id => false do |t|   # suppress primary key :id
    	t.integer "admin_user_id"     # 1st foreign key to add
    	t.integer "page_id"		     # 2nd foreign key to add
    end
    # add an index for faster lookups, passes in an array, creates lookups on both columns
    add_index :admin_users_pages, ["admin_user_id", "page_id"]
  end
end
