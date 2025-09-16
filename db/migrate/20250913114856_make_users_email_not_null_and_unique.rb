class MakeUsersEmailNotNullAndUnique < ActiveRecord::Migration[7.1]
  def up
    # Set a default, backfill existing NULLs, then enforce NOT NULL
    change_column_default :users, :email, ""
    execute "UPDATE users SET email = '' WHERE email IS NULL"

    change_column_null :users, :email, false

    # Ensure a unique index exists (guard in case it already does)
    add_index :users, :email, unique: true unless index_exists?(:users, :email)
  end

  def down
    # Rollback path
    remove_index :users, :email if index_exists?(:users, :email)
    change_column_null :users, :email, true
    change_column_default :users, :email, nil
  end
end
