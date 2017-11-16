require 'test/unit'
require_relative '../history_manager'

class Test_HistoryManager < Test::Unit::TestCase

  def test_addState
    h0 = HistoryManager.new.history
    state = "abc"

    h1 = HistoryManager.addState(history: h0, state: state)
    currentState = HistoryManager.currentState(history: h1)
    self.assert_equal(currentState, "abc")

    state[2] = "q"

    self.assert_equal(state, "abq")
    self.assert_equal(currentState, "abc")
  end

  def test_currentState
    h0 = HistoryManager.new.history

    currentState = HistoryManager.currentState(history: h0)
    self.assert_equal(currentState, nil)

    h1 = HistoryManager.addState(history: h0, state: 1)
    currentState = HistoryManager.currentState(history: h1)
    self.assert_equal(currentState, 1)
  end

  def test_removeCurrentState
    h0 = HistoryManager.new.history

    h1 = HistoryManager.addState(history: h0, state: 1)
    h2 = HistoryManager.addState(history: h1, state: 2)
    h3 = HistoryManager.addState(history: h2, state: 3)

    h4 = HistoryManager.removeCurrentState(history: h3)
    currentState = HistoryManager.currentState(history: h4)
    self.assert_equal(currentState, 2)

    h5 = HistoryManager.removeCurrentState(history: h4)
    currentState = HistoryManager.currentState(history: h5)
    self.assert_equal(currentState, 1)

    h6 = HistoryManager.removeCurrentState(history: h5)
    currentState = HistoryManager.currentState(history: h6)
    self.assert_equal(currentState, nil)

    h7 = HistoryManager.removeCurrentState(history: h6)
    currentState = HistoryManager.currentState(history: h7)
    self.assert_equal(currentState, nil)
  end

end

