class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :animation
      t.text :body

      t.timestamps
    end
  end
end
