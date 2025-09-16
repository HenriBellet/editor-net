class AddFieldsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :title, :string
    add_column :posts, :content, :text
    add_reference :posts, :user, null: false, foreign_key: true
  end
end
