class AddUserAndPostToComments < ActiveRecord::Migration[7.1]
  def up
    add_reference :comments, :user, foreign_key: true
    add_reference :comments, :post, foreign_key: true
    # If the table already has rows, backfill or allow NULLs temporarily.
    # Example backfill to the first user/post (optional):
    # execute "UPDATE comments SET user_id = (SELECT id FROM users LIMIT 1) WHERE user_id IS NULL"
    # execute "UPDATE comments SET post_id = (SELECT id FROM posts LIMIT 1) WHERE post_id IS NULL"
    # Then enforce NOT NULL if you want:
    # change_column_null :comments, :user_id, false
    # change_column_null :comments, :post_id, false
  end

  def down
    remove_reference :comments, :post, foreign_key: true
    remove_reference :comments, :user, foreign_key: true
  end
end
