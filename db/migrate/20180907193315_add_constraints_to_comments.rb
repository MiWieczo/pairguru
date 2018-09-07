class AddConstraintsToComments < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :text, :string, null: false
    change_column :comments, :movie_id, :integer, null: false
    change_column :comments, :user_id, :integer, null: false
  end
end
