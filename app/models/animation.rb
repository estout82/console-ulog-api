
class Animation < ApplicationRecord
    has_secure_password :secret
    has_many :frames, class_name: "AnimationFrame"

    validates :name, :slug, presence: true
end
