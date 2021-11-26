class CreateAnimations < ActiveRecord::Migration[6.1]
  def change
    create_table :animations do |t|
      t.string :name
      t.string :slug
      t.string :secret

      t.timestamps
    end

    create_table :animation_frames do |t|
      t.integer :order
      t.string :data
      t.references :animation, null: false, foreign_key: true

      t.timestamps
    end

    create_table :messages do |t|
      t.text :body
      t.string :color
      t.references :animation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
