require 'test/unit'
require_relative '../history_manager'

class Test_HistoryManager < Test::Unit::TestCase

  def test_add_state
    h0 = HistoryManager.initial_history
    state = 'abc'

    h1 = HistoryManager.add_state(history: h0, state: state)
    current_state = HistoryManager.current_state(history: h1)
    self.assert_equal('abc', current_state)

    state[2] = 'q'

    self.assert_equal('abq', state)
    self.assert_equal('abq', current_state) # but HistoryManager functions are pure
  end

  def test_current_state
    h0 = HistoryManager.initial_history

    current_state = HistoryManager.current_state(history: h0)
    self.assert_equal(nil, current_state)

    h1 = HistoryManager.add_state(history: h0, state: 1)
    current_state = HistoryManager.current_state(history: h1)
    self.assert_equal(1, current_state)
  end

  def test_remove_current_state
    h0 = HistoryManager.initial_history

    current_state = HistoryManager.current_state(history: h0)
    self.assert_equal(nil, current_state)

    h1 = HistoryManager.add_state(history: h0, state: 1)
    h2 = HistoryManager.add_state(history: h1, state: 2)
    h3 = HistoryManager.add_state(history: h2, state: 3)

    h4 = HistoryManager.remove_current_state(history: h3)
    current_state = HistoryManager.current_state(history: h4)
    self.assert_equal(2, current_state)

    h5 = HistoryManager.remove_current_state(history: h4)
    current_state = HistoryManager.current_state(history: h5)
    self.assert_equal(1, current_state)

    h6 = HistoryManager.remove_current_state(history: h5)
    current_state = HistoryManager.current_state(history: h6)
    self.assert_equal(nil, current_state)
  end

end

