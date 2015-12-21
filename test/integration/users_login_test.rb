require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
  	@user = users(:frank)
  end

  test "login with invalid information" do
    get login_path #get to the login page
    assert_template 'sessions/new'  #make sure that the template is rendered
    post login_path, session: { email: "", password: "" } #post a blank session
    assert_template 'sessions/new' #make sure the template loads again, no errors 
    assert_not flash.empty? #make sure the error is displayed
    get about_path #go to another page
    assert flash.empty? #make sure the error is removed and Boom!
  end
  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
     # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end