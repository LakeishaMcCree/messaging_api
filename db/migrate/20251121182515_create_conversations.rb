class CreateConversations < ActiveRecord::Migration[8.1]
  def change
    create_table :conversations do |t|
      t.string :title
      t.string :conversation_type
      t.string :string

      t.timestamps
    end
  end
end
