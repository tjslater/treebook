require 'test_helper'

class UserTest < ActiveSupport::TestCase
	should have_many (:user_friendships)
	should have_many (:friends)
	should have_many (:pending_user_friendships)
	should have_many (:pending_friends)
	should have_many (:requested_user_friendships)
	should have_many (:requested_friends)
	should have_many (:blocked_user_friendships)
	should have_many (:blocked_friends)


	test "a user should enter a first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?

	end	

	test "a user should enter a last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?

	end	

	test "a user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?

	end

	test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'Jason', last_name: 'Seifer', email: 'jason2@teamtreehouse.com')
    user.password = user.password_confirmation = 'asdfasdf'
    user.profile_name = "My Profile With Spaces"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Jason', last_name: 'Seifer', email: 'jason2@teamtreehouse.com')
    user.password = user.password_confirmation = 'asdfasdf'

    user.profile_name = 'jasonseifer_1'
    assert user.valid?
  end

	test "that no error is raised when trying to access a friend list" do
		assert_nothing_raised do
			users(:baggins).friends
		end

	end
	test "that creating friendships on a user works" do
		users(:baggins).pending_friends << users(:samwise)
		users(:baggins).pending_friends.reload
		assert users(:baggins).pending_friends.include?(users(:samwise))
	end

	test "that calling to_param on a user returns the profile_name" do
	assert_equal "bilbo_baggins", users(:baggins).to_param
	end

	context "#has_blocked?" do
		should "return true if a user has blocked another user" do
			assert users(:baggins).has_blocked?(users(:blocked_friend))
		end

		should "return false if a user has not blocked another user" do
			assert !users(:baggins).has_blocked?(users(:gandalf))
			
		end
	end
end
