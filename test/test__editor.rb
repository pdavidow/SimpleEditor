require 'test/unit'
require_relative '../editor'
require_relative '../history_manager'
require_relative '../editor_exceptions'
require_relative 'helper'
# todo needs work
class Test_Editor < Test::Unit::TestCase
  include Helper
  include EditorExceptions

  def test_append_1
    h1 = HistoryManager.initial_history

    appendage_string1 = 'ab3'
    h2 = Editor.append(history: h1, appendage_string: appendage_string1)
    current_string_state1 = HistoryManager.current_string_state(history: h2)

    self.assert_equal('ab3', current_string_state1)
    self.assert_equal([:''], h1)
    self.assert_equal([:'', :'ab3'], h2)

    appendage_string2 = 'deF'
    h3 = Editor.append(history: h2, appendage_string: appendage_string2)
    current_string_state2 = HistoryManager.current_string_state(history: h3)

    self.assert_equal('ab3deF', current_string_state2)
    self.assert_equal([:''], h1)
    self.assert_equal([:'', :'ab3'], h2)
    self.assert_equal([:'', :'ab3', :'ab3deF'], h3)
  end

  def test_deleteLastChars_1
    h1 = HistoryManager.initial_history

    appendage_string = 'abcdef'
    h2 = Editor.append(history: h1, appendage_string: appendage_string)
    current_string_state1 = HistoryManager.current_string_state(history: h2)

    self.assert_equal('abcdef', current_string_state1)
    self.assert_equal([:''], h1)

    count = 1
    h3 = Editor.delete_last_chars(history: h2, chars_to_delete_count: count)
    current_string_state2 = HistoryManager.current_string_state(history: h3)

    self.assert_equal('abcde', current_string_state2)
    self.assert_equal([:''], h1)
    self.assert_equal([:'', :'abcdef'], h2)

    count = 5
    h4 = Editor.delete_last_chars(history: h3, chars_to_delete_count: count)
    current_string_state3 = HistoryManager.current_string_state(history: h4)

    self.assert_equal('', current_string_state3)
    self.assert_equal([:''], h1)
    self.assert_equal([:'', :'abcdef'], h2)
    self.assert_equal([:'', :'abcdef', :'abcde'], h3)
    self.assert_equal([:'', :'abcdef', :'abcde', :''], h4)
  end

  def test_deleteLastChars_2
    h1 = HistoryManager.initial_history

    appendage_string = 'abcdef'
    h2 = Editor.append(history: h1, appendage_string: appendage_string)
    current_string_state = HistoryManager.current_string_state(history: h2)

    self.assert_equal('abcdef', current_string_state)

    count = 7

    exception = self.assert_raise(CharArgumentError){Editor.delete_last_chars(history: h2, chars_to_delete_count: count)}
    self.assert_equal('1 <= count <= string length', exception.message)

    current_state = HistoryManager.current_state(history: h2)
    self.assert_equal(:'abcdef', current_state)
  end

  def test_deleteLastChars_3
    h1 = HistoryManager.initial_history

    appendage_string = 'abcdef'
    h2 = Editor.append(history: h1, appendage_string: appendage_string)
    current_string_state1 = HistoryManager.current_string_state(history: h2)

    self.assert_equal('abcdef', current_string_state1)

    count = 0

    exception = self.assert_raise(CharArgumentError){Editor.delete_last_chars(history: h2, chars_to_delete_count: count)}
    self.assert_equal('1 <= count <= string length', exception.message)

    current_string_state2 = HistoryManager.current_string_state(history: h2)
    self.assert_equal('abcdef', current_string_state2)
  end

  def test_deleteLastChars_4
    h1 = HistoryManager.initial_history
    current_string_state1 = HistoryManager.current_string_state(history: h1)

    self.assert_equal('', current_string_state1)

    count = 1

    exception = self.assert_raise(ArgumentError){Editor.delete_last_chars(history: h1, chars_to_delete_count: count)}
    self.assert_equal('String may not be empty', exception.message)

    current_string_state2 = HistoryManager.current_string_state(history: h1)
    self.assert_equal('', current_string_state2)
  end

  def test_charAtPosition_1
    h1 = HistoryManager.initial_history

    appendage_string = 'abc'
    h2 = Editor.append(history: h1, appendage_string: appendage_string)

    position = 3

    result = Editor.char_at_position(history: h2, position: position)
    self.assert_equal('c', result)
  end

  def test_charAtPosition_2
    h1 = HistoryManager.initial_history

    appendage_string = 'abc'
    h2 = Editor.append(history: h1, appendage_string: appendage_string)

    position = 1

    result = Editor.char_at_position(history: h2, position: position)
    self.assert_equal('a', result)
  end

  def test_charAtPosition_3
    h1 = HistoryManager.initial_history

    appendage_string = 'abc'
    h2 = Editor.append(history: h1, appendage_string: appendage_string)

    position = 0

    exception = self.assert_raise(CharArgumentError){Editor.char_at_position(history: h2, position: position)}
    self.assert_equal('1 <= position <= string length', exception.message)
  end

  def test_charAtPosition_4
    h1 = HistoryManager.initial_history

    appendage_string = 'abc'
    h2 = Editor.append(history: h1, appendage_string: appendage_string)

    position = 4

    exception = self.assert_raise(CharArgumentError){Editor.char_at_position(history: h2, position: position)}
    self.assert_equal('1 <= position <= string length', exception.message)
  end

  def test_char_at_position_5
    h1 = HistoryManager.initial_history

    appendage_string = ''
    h2 = Editor.append(history: h1, appendage_string: appendage_string)

    position = 1

    exception = self.assert_raise(ArgumentError){Editor.char_at_position(history: h2, position: position)}
    self.assert_equal('String may not be empty', exception.message)
  end

  def test_print_with_newline__char_at_1
    h1 = HistoryManager.initial_history

    appendage_string = 'abc'
    h2 = Editor.append(history: h1, appendage_string: appendage_string)
    appendage_string = 'def'
    h3 = Editor.append(history: h2, appendage_string: appendage_string)

    position = 6
    result = Helper.with_captured_stdout {Editor.print_with_newline__char_at(position: position, history: h3)}
    self.assert_equal(result, "f\n")
  end

  def test_print_with_newline__char_at_2
    h1 = HistoryManager.initial_history

    appendage_string = 'abc'
    h2 = Editor.append(history: h1, appendage_string: appendage_string)

    position = 0
    exception = self.assert_raise(CharArgumentError){Editor.print_with_newline__char_at(position: position, history: h2)}
    self.assert_equal('1 <= position <= string length', exception.message)
  end


  def test_print_with_newline__char_at_3
    h1 = HistoryManager.initial_history

    appendage_string = 'abc'
    h2 = Editor.append(history: h1, appendage_string: appendage_string)

    position = 4
    exception = self.assert_raise(CharArgumentError){Editor.print_with_newline__char_at(position: position, history: h2)}
    self.assert_equal('1 <= position <= string length', exception.message)
  end

  def test_undo
    h1 = HistoryManager.initial_history

    appendage_string = 'a'
    h2 = Editor.append(history: h1, appendage_string: appendage_string)
    appendage_string = 'b'
    h3 = Editor.append(history: h2, appendage_string: appendage_string)
    appendage_string = 'c'
    h4 = Editor.append(history: h3, appendage_string: appendage_string)
    self.assert_equal('abc', Editor.string_state(history: h4))

    h5 = Editor.undo(history: h4)
    self.assert_equal('ab', Editor.string_state(history: h5))

    h6 = Editor.undo(history: h5)
    self.assert_equal('a', Editor.string_state(history: h6))

    h7 = Editor.undo(history: h6)
    self.assert_equal('', Editor.string_state(history: h7))

    h8 = Editor.undo(history: h7)
    self.assert_equal('', Editor.string_state(history: h8))
  end
end
