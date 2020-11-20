class AddRepoToPointedEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :pointed_events, :repo, :string
  end
end
