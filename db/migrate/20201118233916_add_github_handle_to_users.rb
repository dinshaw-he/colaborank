class AddGithubHandleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :github, :string
  end
end
