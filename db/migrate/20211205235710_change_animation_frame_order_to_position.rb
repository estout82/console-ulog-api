class ChangeAnimationFrameOrderToPosition < ActiveRecord::Migration[6.1]
  def change
    change_table :animation_frames do |t|
      t.rename :order, :position
    end
  end
end
