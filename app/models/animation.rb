
class Animation < ApplicationRecord
    has_secure_password :secret
    has_many :frames, class_name: "AnimationFrame"
    has_many :chats

    validates :name, :slug, presence: true
    validates :slug, uniqueness: true

    # TODO: pre-save hook to url format the slug

    def slug_must_contain_only_url_allowed_chars
        
    end
end
