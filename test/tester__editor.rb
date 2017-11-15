require 'test/unit'
require_relative '../history_manager'
require_relative '../editor'

class Tester_Editor < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
  end

  def test_initialState
    result = Editor.initialState

    self.assert_equal("", result)
  end

end

