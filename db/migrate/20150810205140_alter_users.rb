class AlterUsers < ActiveRecord::Migration
  def up
    rename_table("users", "admin_users")             # users will no longer exist after this entry
    add_column("admin_users", "username", :string, :limit => 25, :after => "email")
    change_column("admin_users", "email", :string, :limit => 100)
    rename_column("admin_users", "password", "hashed_password")
    add_index("admin_users", "username")
  end	

  def down                            #notice how these are reversed from above
    remove_index("admin_users", "username")
    rename_column("admin_users", "hashed_password", "password")
    change_column("admin_users", "email", :string, :default => "", :null => false)
    remove_column("admin_users", "username")
    rename_table("admin_users", "users")
  end

end
