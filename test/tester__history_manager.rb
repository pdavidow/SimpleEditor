require 'test/unit'
require_relative '../history_manager'

class Tester_HistoryManager < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
  end

  def test_currentState
    HistoryManager.resetHistory
    h = HistoryManager.history

    currentState = HistoryManager.currentState(history:h)
    self.assert_equal(currentState, nil)

    h.push(1)
    currentState = HistoryManager.currentState(history:h)
    self.assert_equal(currentState, 1)
  end

  def test_undo
    HistoryManager.resetHistory
    h1 = HistoryManager.history

    h1.push(1)
    h1.push(2)
    h1.push(3)

    h2 = HistoryManager.undo(history:h1)
    currentState = HistoryManager.currentState(history:h2)
    self.assert_equal(currentState, 2)

    h3 = HistoryManager.undo(history:h2)
    currentState = HistoryManager.currentState(history:h3)
    self.assert_equal(currentState, 1)
  end
end

