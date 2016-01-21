require 'test_helper'


class StaticPagesControllerTest < ActionController::TestCase

def setup
    @base_title = "DanceFest"
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "DanceFest"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | DanceFest"
  end

  test "should get about" do
  	get :about
  	assert_response :success
  	 assert_select "title", "About | DanceFest"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

end
