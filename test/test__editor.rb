require 'test/unit'
require_relative '../editor'
require_relative '../history_manager'

class Test_Editor < Test::Unit::TestCase

  def test_initialState
    self.assert_equal("", Editor.initial_state)
  end

  def test_append_1
    h0 = HistoryManager.new.history
    h1 = HistoryManager.add_state(history: h0, state: Editor.initial_state)

    appendage_string = "ab3"
    h2 = Editor.append(history: h1, appendage_string: appendage_string)
    current_state = HistoryManager.current_state(history: h2)

    self.assert_equal("ab3", current_state)

    appendage_string = "deF"
    h3 = Editor.append(history: h2, appendage_string: appendage_string)
    current_state = HistoryManager.current_state(history: h3)

    self.assert_equal("ab3deF", current_state)
  end

  def test_deleteLastChars_1
    h0 = HistoryManager.new.history
    h1 = HistoryManager.add_state(history: h0, state: Editor.initial_state)

    appendage_string = "abcdef"
    h2 = Editor.append(history: h1, appendage_string: appendage_string)
    current_state = HistoryManager.current_state(history: h2)

    self.assert_equal("abcdef", current_state)

    count = 1
    h3 = Editor.delete_last_chars(history: h2, chars_to_delete_count: count)
    current_state = HistoryManager.current_state(history: h3)

    self.assert_equal("abcde", current_state)

    count = 5
    h4 = Editor.delete_last_chars(history: h3, chars_to_delete_count: count)
    current_state = HistoryManager.current_state(history: h4)

    self.assert_equal("", current_state)
  end

  def test_deleteLastChars_2
    h0 = HistoryManager.new.history
    h1 = HistoryManager.add_state(history: h0, state: Editor.initial_state)

    appendage_string = "abcdef"
    h2 = Editor.append(history: h1, appendage_string: appendage_string)
    current_state = HistoryManager.current_state(history: h2)

    self.assert_equal("abcdef", current_state)

    count = 7

    exception = self.assert_raise(ArgumentError){Editor.delete_last_chars(history: h2, chars_to_delete_count: count)}
    self.assert_equal("1 >= count <= string length", exception.message)

    current_state = HistoryManager.current_state(history: h2)
    self.assert_equal("abcdef", current_state)
  end

  def test_deleteLastChars_3
    h0 = HistoryManager.new.history
    h1 = HistoryManager.add_state(history: h0, state: Editor.initial_state)

    appendage_string = "abcdef"
    h2 = Editor.append(history: h1, appendage_string: appendage_string)
    current_state = HistoryManager.current_state(history: h2)

    self.assert_equal("abcdef", current_state)

    count = 0

    exception = self.assert_raise(ArgumentError){Editor.delete_last_chars(history: h2, chars_to_delete_count: count)}
    self.assert_equal("1 >= count <= string length", exception.message)

    current_state = HistoryManager.current_state(history: h2)
    self.assert_equal("abcdef", current_state)
  end

  def test_deleteLastChars_4
    h0 = HistoryManager.new.history
    h1 = HistoryManager.add_state(history: h0, state: Editor.initial_state)
    current_state = HistoryManager.current_state(history: h1)

    self.assert_equal("", current_state)

    count = 1

    exception = self.assert_raise(ArgumentError){Editor.delete_last_chars(history: h1, chars_to_delete_count: count)}
    self.assert_equal("String may not be empty", exception.message)

    current_state = HistoryManager.current_state(history: h1)
    self.assert_equal("", current_state)
  end

  def test_charAtPosition_1
    s = "abc"
    k = 3

    result = Editor.char_at_position(string: s, position: k)

    self.assert_equal("c", result)

    self.assert_equal("abc", s)
    self.assert_equal(3, k)
  end

  def test_charAtPosition_2
    s = "abc"
    k = 1

    result = Editor.char_at_position(string: s, position: k)

    self.assert_equal("a", result)

    self.assert_equal("abc", s)
    self.assert_equal(1, k)
  end

  def test_charAtPosition_3
    s = "abc"
    k = 0

    exception = self.assert_raise(ArgumentError){Editor.char_at_position(string: s, position: k)}
    self.assert_equal("1 >= position <= string length", exception.message)

    self.assert_equal("abc", s)
    self.assert_equal(0, k)
  end

  def test_charAtPosition_4
    s = "abc"
    k = 4

    exception = self.assert_raise(ArgumentError){Editor.char_at_position(string: s, position: k)}
    self.assert_equal("1 >= position <= string length", exception.message)

    self.assert_equal("abc", s)
    self.assert_equal(4, k)
  end

  def test_char_at_position_5
    s = ""
    k = 1

    exception = self.assert_raise(ArgumentError){Editor.char_at_position(string: s, position: k)}
    self.assert_equal("String may not be empty", exception.message)

    self.assert_equal("", s)
    self.assert_equal(1, k)
  end
end
