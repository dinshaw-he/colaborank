class CreatePointedEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :pointed_events, id: :uuid do |t|
      t.integer :value
      t.uuid :user_id
      t.string :type
      t.text :description

      t.timestamps
    end
  end
end
