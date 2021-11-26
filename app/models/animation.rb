class Animation < ApplicationRecord
    has_many :frames, class_name: "AnimationFrame"
end
