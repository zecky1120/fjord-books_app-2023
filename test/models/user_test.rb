# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "name_or_email" do
    alice = users(:alice)
    bob = users(:bob)
    assert_equal 'alice@example.com', alice.name_or_email
    assert_equal 'ボブ', bob.name_or_email
  end
end
