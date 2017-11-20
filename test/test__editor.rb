require 'test/unit'
require_relative '../editor'
require_relative '../history_manager'

class Test_Editor < Test::Unit::TestCase

  def test_initialState
    self.assert_equal("", Editor.initialState)
  end

  def test_append_1
    h0 = HistoryManager.new.history
    h1 = HistoryManager.addState(history: h0, state: Editor.initialState)

    appendageString = "ab3"
    h2 = Editor.append(history: h1, appendageString: appendageString)
    currentState = HistoryManager.currentState(history: h2)

    self.assert_equal("ab3", currentState)

    appendageString = "deF"
    h3 = Editor.append(history: h2, appendageString: appendageString)
    currentState = HistoryManager.currentState(history: h3)

    self.assert_equal("ab3deF", currentState)
  end

  def test_deleteLastChars_1
    h0 = HistoryManager.new.history
    h1 = HistoryManager.addState(history: h0, state: Editor.initialState)

    appendageString = "abcdef"
    h2 = Editor.append(history: h1, appendageString: appendageString)
    currentState = HistoryManager.currentState(history: h2)

    self.assert_equal("abcdef", currentState)

    count = 1
    h3 = Editor.deleteLastChars(history: h2, charsToDeleteCount: count)
    currentState = HistoryManager.currentState(history: h3)

    self.assert_equal("abcde", currentState)

    count = 5
    h4 = Editor.deleteLastChars(history: h3, charsToDeleteCount: count)
    currentState = HistoryManager.currentState(history: h4)

    self.assert_equal("", currentState)
  end

  def test_deleteLastChars_2
    h0 = HistoryManager.new.history
    h1 = HistoryManager.addState(history: h0, state: Editor.initialState)

    appendageString = "abcdef"
    h2 = Editor.append(history: h1, appendageString: appendageString)
    currentState = HistoryManager.currentState(history: h2)

    self.assert_equal("abcdef", currentState)

    count = 7

    exception = self.assert_raise(ArgumentError){Editor.deleteLastChars(history: h2, charsToDeleteCount: count)}
    self.assert_equal("1 >= count <= string length", exception.message)

    currentState = HistoryManager.currentState(history: h2)
    self.assert_equal("abcdef", currentState)
  end

  def test_deleteLastChars_3
    h0 = HistoryManager.new.history
    h1 = HistoryManager.addState(history: h0, state: Editor.initialState)

    appendageString = "abcdef"
    h2 = Editor.append(history: h1, appendageString: appendageString)
    currentState = HistoryManager.currentState(history: h2)

    self.assert_equal("abcdef", currentState)

    count = 0

    exception = self.assert_raise(ArgumentError){Editor.deleteLastChars(history: h2, charsToDeleteCount: count)}
    self.assert_equal("1 >= count <= string length", exception.message)

    currentState = HistoryManager.currentState(history: h2)
    self.assert_equal("abcdef", currentState)
  end

  def test_deleteLastChars_4
    h0 = HistoryManager.new.history
    h1 = HistoryManager.addState(history: h0, state: Editor.initialState)
    currentState = HistoryManager.currentState(history: h1)

    self.assert_equal("", currentState)

    count = 1

    exception = self.assert_raise(ArgumentError){Editor.deleteLastChars(history: h1, charsToDeleteCount: count)}
    self.assert_equal("String may not be empty", exception.message)

    currentState = HistoryManager.currentState(history: h1)
    self.assert_equal("", currentState)
  end

  def test_charAtPosition_1
    s = "abc"
    k = 3

    result = Editor.charAtPosition(string: s, position: k)

    self.assert_equal("c", result)

    self.assert_equal("abc", s)
    self.assert_equal(3, k)
  end

  def test_charAtPosition_2
    s = "abc"
    k = 1

    result = Editor.charAtPosition(string: s, position: k)

    self.assert_equal("a", result)

    self.assert_equal("abc", s)
    self.assert_equal(1, k)
  end

  def test_charAtPosition_3
    s = "abc"
    k = 0

    exception = self.assert_raise(ArgumentError){Editor.charAtPosition(string: s, position: k)}
    self.assert_equal("1 >= position <= string length", exception.message)

    self.assert_equal("abc", s)
    self.assert_equal(0, k)
  end

  def test_charAtPosition_4
    s = "abc"
    k = 4

    exception = self.assert_raise(ArgumentError){Editor.charAtPosition(string: s, position: k)}
    self.assert_equal("1 >= position <= string length", exception.message)

    self.assert_equal("abc", s)
    self.assert_equal(4, k)
  end

  def test_charAtPosition_5
    s = ""
    k = 1

    exception = self.assert_raise(ArgumentError){Editor.charAtPosition(string: s, position: k)}
    self.assert_equal("String may not be empty", exception.message)

    self.assert_equal("", s)
    self.assert_equal(1, k)
  end
end
