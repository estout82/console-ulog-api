class FeatureSecureAnimationSecrets < ActiveRecord::Migration[6.1]
  def change
    change_table :animations do |t|
      t.rename :secret, :secret_digest
    end
  end
end
