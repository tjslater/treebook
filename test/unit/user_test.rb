require 'test_helper'

class UserTest < ActiveSupport::TestCase
	should have_many (:user_friendships)
	should have_many (:friends)


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
		user = User.new(first_name: 'bil', last_name:'bag', email: 'bil@baggins.com')
		user.password = user.password_confirmation = 'password'

		user.profile_name = "My Profile with spaces"

		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("Must be formatted correctly")

	end	

	test "a user can have a correctly formatted profile name" do
		user = User.new(first_name: 'bil', last_name:'bag', email: 'bil@baggins.com')
		user.password = user.password_confirmation = 'password'

		user.profile_name = 'bilbobaggins_2'
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
end
