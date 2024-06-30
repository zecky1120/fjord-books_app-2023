# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "name_or_email" do
    user = User.new(name: '', email: 'foo@example.com')
    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'Foo Bar'
    assert_equal 'Foo Bar', user.name_or_email
  end
end
