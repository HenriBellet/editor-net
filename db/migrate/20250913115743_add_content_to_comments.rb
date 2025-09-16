class AddContentToComments < ActiveRecord::Migration[7.1]
  def up
    add_column :comments, :content, :text
    # Optional hardening:
    # execute "UPDATE comments SET content = '' WHERE content IS NULL"
    # change_column_null :comments, :content, false
  end

  def down
    remove_column :comments, :content
  end
end
