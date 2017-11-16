require 'test/unit'
require_relative '../editor'
require_relative '../history_manager'
require_relative '../editor_string_exceptions'

class Tester_Editor < Test::Unit::TestCase
  include EditorStringExceptions

  def test_initialState
    self.assert_equal("", Editor.initialState)
  end

  def test_append_1
    h0 = HistoryManager.new.history
    h1 = HistoryManager.addState(history: h0, state: Editor.initialState)

    appendageString = "abc"
    h2 = Editor.append(history: h1, appendageString: appendageString)
    currentState = HistoryManager.currentState(history: h2)

    self.assert_equal("abc", currentState)

    appendageString = "def"
    h3 = Editor.append(history: h2, appendageString: appendageString)
    currentState = HistoryManager.currentState(history: h3)

    self.assert_equal("abcdef", currentState)
  end

  def test_append_2
    h0 = HistoryManager.new.history
    h1 = HistoryManager.addState(history: h0, state: Editor.initialState)
    currentState1 = HistoryManager.currentState(history: h1)

    appendageString = "abC"
    exception = self.assert_raise(LowerCaseError){Editor.append(history: h1, appendageString: appendageString)}
    self.assert_equal("Appendage must be all lower case", exception.message)

    currentState2 = HistoryManager.currentState(history: h1)

    self.assert_equal(currentState1, currentState2)
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

    exception = self.assert_raise(OutOfBoundsError){Editor.deleteLastChars(history: h2, charsToDeleteCount: count)}
    self.assert_equal("1 >= char count <= string length", exception.message)

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

    exception = self.assert_raise(OutOfBoundsError){Editor.deleteLastChars(history: h2, charsToDeleteCount: count)}
    self.assert_equal("1 >= char count <= string length", exception.message)

    currentState = HistoryManager.currentState(history: h2)
    self.assert_equal("abcdef", currentState)
  end

  def test_deleteLastChars_4
    h0 = HistoryManager.new.history
    h1 = HistoryManager.addState(history: h0, state: Editor.initialState)
    currentState = HistoryManager.currentState(history: h1)

    self.assert_equal("", currentState)

    count = 1

    exception = self.assert_raise(EmptyStringError){Editor.deleteLastChars(history: h1, charsToDeleteCount: count)}
    self.assert_equal("String may not be empty", exception.message)

    currentState = HistoryManager.currentState(history: h1)
    self.assert_equal("", currentState)
  end
end

