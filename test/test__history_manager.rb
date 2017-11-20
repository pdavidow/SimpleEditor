require 'test/unit'
require_relative '../history_manager'

class Test_HistoryManager < Test::Unit::TestCase

  def test_add_state
    h0 = HistoryManager.new.history
    state = "abc"

    h1 = HistoryManager.add_state(history: h0, state: state)
    current_state = HistoryManager.current_state(history: h1)
    self.assert_equal(current_state, "abc")

    state[2] = "q"

    self.assert_equal(state, "abq")
    self.assert_equal(current_state, "abc")
  end

  def test_current_state
    h0 = HistoryManager.new.history

    current_state = HistoryManager.current_state(history: h0)
    self.assert_equal(current_state, nil)

    h1 = HistoryManager.add_state(history: h0, state: 1)
    current_state = HistoryManager.current_state(history: h1)
    self.assert_equal(current_state, 1)
  end

  def test_remove_current_state
    h0 = HistoryManager.new.history

    h1 = HistoryManager.add_state(history: h0, state: 1)
    h2 = HistoryManager.add_state(history: h1, state: 2)
    h3 = HistoryManager.add_state(history: h2, state: 3)

    h4 = HistoryManager.remove_current_state(history: h3)
    current_state = HistoryManager.current_state(history: h4)
    self.assert_equal(current_state, 2)

    h5 = HistoryManager.remove_current_state(history: h4)
    current_state = HistoryManager.current_state(history: h5)
    self.assert_equal(current_state, 1)

    h6 = HistoryManager.remove_current_state(history: h5)
    current_state = HistoryManager.current_state(history: h6)
    self.assert_equal(current_state, nil)

    h7 = HistoryManager.remove_current_state(history: h6)
    current_state = HistoryManager.current_state(history: h7)
    self.assert_equal(current_state, nil)
  end

end

