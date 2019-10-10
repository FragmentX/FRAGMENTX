require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def_password = 'TestPassword123'
  def_email    = 'test@gmail.com'
  def_name     = 'testName'

  test 'Create user withour email' do
    user = User.new(password: def_password,
                    password_confirmation: def_password,
                    name: def_name)
    assert_equal user.valid?, false
  end

  test 'Create user withour name' do
    user = User.new(email:def_email,
                    password: def_password,
                    password_confirmation: def_password)
    assert_equal user.valid?, false
  end

  test 'Valid User' do
    user = User.new(email:def_email,
                    password: def_password,
                    password_confirmation: def_password,
                    name: def_name)
    assert_equal user.valid?, true
  end

end