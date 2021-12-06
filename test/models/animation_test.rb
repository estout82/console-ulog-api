require "test_helper"

class AnimationTest < ActiveSupport::TestCase
    test "a valid animation saves" do
        animation = new_valid_animation
        assert animation.save
    end

    test "must have name" do
        animation = new_valid_animation
        animation.name = nil
        assert_not animation.save
    end

    test "must have slug" do
        animation = new_valid_animation
        animation.slug = nil
        assert_not animation.save
    end

    test "slug must not contain spaces" do
        # no spaces
        # no unacceptable chars

        animation = new_valid_animation
        animation.slug = "a slug"
        assert_not animation.save
    end

    test "slug must be unique" do
        animation = new_valid_animation
        animation.slug = "test"
        assert_not animation.save
    end

    test "secret is hashed" do
        animation = new_valid_animation
        assert animation.save
        assert_not_equal animation.secret_digest, "1234"
    end

    test "secret comparisson should work" do
        # use the has_secure_password to compare secret to 1234
        animation = animations(:one)
        assert animation.authenticate_secret("1234")
    end

    test "frames relationship works" do
        animation = animations(:one)
        assert animation.frames.count > 1
    end

    private

    def new_valid_animation
        animation = Animation.new
        animation.name = "Test Name"
        animation.slug = "test-name"
        animation.secret = "1234"
        return animation
    end
end
