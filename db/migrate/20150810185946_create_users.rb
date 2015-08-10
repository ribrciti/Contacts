class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
    	t.column "first_name", :string, :limit => 25   # writing long way -including column
    	t.string "last_name", :limit => 50    # writing short way - not using column
    	t.string "email", :default => "", :null => "false" 
			t.string "password", :limit => 40
      #t.datetime "created_at"
      #t.datetime "updated_at" -both are included in t.timestamps below
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end

