require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @non_activated_user = users(:ashton)
    @non_admin = users(:lucy)
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "should only display users who have activated their account" do
    # Activated user.
    log_in_as(@user)
    assert @user.activated?
    get users_path
    assert_template 'users/index'
    assert_match @user.name, response.body
    assert_select "a[href=?]", user_path(@user)

    # Non-activated user.
    assert_not @non_activated_user.activated?
    refute_match @non_activated_user.name, response.body
  end
end
