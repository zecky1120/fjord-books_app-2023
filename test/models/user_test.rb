# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name_or_email' do
    alice = users(:alice)
    carol = users(:carol)
    assert_equal 'アリス', alice.name_or_email
    assert_equal 'carol@example.com', carol.name_or_email
  end
end
