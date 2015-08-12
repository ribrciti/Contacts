class CreateSectionEdits < ActiveRecord::Migration
  def change
    create_table :section_edits do |t|
			t.references :admin_user			   # foreign key 1
    	t.references :section		         # foreign key 2
			t.string :summary   				     # add a field for summary notes
      t.timestamps
    end
    add_index :section_edits, ["admin_user_id", "section_id"]     #add index
  end
end

