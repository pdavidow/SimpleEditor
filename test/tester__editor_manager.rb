require 'test/unit'
require_relative '../editor_manager'

class Tester_EditorManager < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
  end

  def test_initialize
    e = EditorManager.new()

    self.assert_equal(e.history, [""])
  end
end

