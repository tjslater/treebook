require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
 should belong_to(:user)
 should belong_to(:friend)
test "that creating a friendship works without raising an exception"  do
	assert_nothing_raised do
		UserFriendship.create user: users(:baggins), friend: users(:samwise)
	end
  end

  test "that creating a friendships based on user id and friend id works" do
  	UserFriendship.create user_id: users(:baggins).id, friend_id: users(:samwise).id
  	assert users(:baggins).friends.include?(users(:samwise))
  end
end