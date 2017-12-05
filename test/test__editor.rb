require 'test/unit'
require_relative 'helper'
require_relative '../constants'
require_relative '../operation'
require_relative '../model'
require_relative '../editor'
require_relative '../history_manager'
require_relative '../editor_exceptions'

class Test_Editor < Test::Unit::TestCase
  include Helper
  include EditorExceptions

  def test_append_1
    m1 = Model.new

    appendage_string1 = 'ab3'
    op1 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string1)
    m2 = Editor.perform_operation(operation: op1, model: m1)
    string_state1 = Editor.string_state(model: m2)

    self.assert_equal('ab3', string_state1)
    self.assert_equal([:''], m1.history)
    self.assert_equal(0, m1.appendage_length_sum)
    self.assert_equal(0, m1.char_delete_count_sum)
    self.assert_equal([:'', :'ab3'], m2.history)
    self.assert_equal(3, m2.appendage_length_sum)
    self.assert_equal(0, m2.char_delete_count_sum)

    appendage_string2 = 'deF'
    op2 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string2)
    m3 = Editor.perform_operation(operation: op2, model: m2)
    string_state2 = Editor.string_state(model: m3)

    self.assert_equal('ab3deF', string_state2)
    self.assert_equal([:''], m1.history)
    self.assert_equal(0, m1.appendage_length_sum)
    self.assert_equal(0, m1.char_delete_count_sum)
    self.assert_equal([:'', :'ab3'], m2.history)
    self.assert_equal(3, m2.appendage_length_sum)
    self.assert_equal(0, m2.char_delete_count_sum)
    self.assert_equal([:'', :'ab3', :'ab3deF'], m3.history)
    self.assert_equal(6, m3.appendage_length_sum)
    self.assert_equal(0, m3.char_delete_count_sum)
  end

  def test_delete_1
    m1 = Model.new

    appendage_string = 'abcdef'
    op1 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string)
    m2 = Editor.perform_operation(operation: op1, model: m1)
    string_state1 = Editor.string_state(model: m2)

    self.assert_equal('abcdef', string_state1)
    self.assert_equal([:''], m1.history)
    self.assert_equal(0, m1.appendage_length_sum)
    self.assert_equal(0, m1.char_delete_count_sum)
    self.assert_equal([:'', :'abcdef'], m2.history)
    self.assert_equal(6, m2.appendage_length_sum)
    self.assert_equal(0, m2.char_delete_count_sum)

    count1 = 1
    op2 = Operation.new(type_code: TYPE_DELETE, arg: count1)
    m3 = Editor.perform_operation(operation: op2, model: m2)
    string_state2 = Editor.string_state(model: m3)

    self.assert_equal('abcde', string_state2)
    self.assert_equal([:''], m1.history)
    self.assert_equal(0, m1.appendage_length_sum)
    self.assert_equal(0, m1.char_delete_count_sum)
    self.assert_equal([:'', :'abcdef'], m2.history)
    self.assert_equal(6, m2.appendage_length_sum)
    self.assert_equal(0, m2.char_delete_count_sum)
    self.assert_equal([:'', :'abcdef', :'abcde'], m3.history)
    self.assert_equal(6, m3.appendage_length_sum)
    self.assert_equal(1, m3.char_delete_count_sum)

    count2 = 5
    op3 = Operation.new(type_code: TYPE_DELETE, arg: count2)
    m4 = Editor.perform_operation(operation: op3, model: m3)
    string_state3 = Editor.string_state(model: m4)

    self.assert_equal('', string_state3)
    self.assert_equal([:''], m1.history)
    self.assert_equal(0, m1.appendage_length_sum)
    self.assert_equal(0, m1.char_delete_count_sum)
    self.assert_equal([:'', :'abcdef'], m2.history)
    self.assert_equal(6, m2.appendage_length_sum)
    self.assert_equal(0, m2.char_delete_count_sum)
    self.assert_equal([:'', :'abcdef', :'abcde'], m3.history)
    self.assert_equal(6, m3.appendage_length_sum)
    self.assert_equal(1, m3.char_delete_count_sum)
    self.assert_equal([:'', :'abcdef', :'abcde', :''], m4.history)
    self.assert_equal(6, m4.appendage_length_sum)
    self.assert_equal(6, m4.char_delete_count_sum)
  end

  def test_delete_2
    m1 = Model.new

    appendage_string = 'abcdef'
    op1 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string)
    m2 = Editor.perform_operation(operation: op1, model: m1)

    string_state = Editor.string_state(model: m2)

    self.assert_equal('abcdef', string_state)
    self.assert_equal([:''], m1.history)
    self.assert_equal(0, m1.appendage_length_sum)
    self.assert_equal(0, m1.char_delete_count_sum)
    self.assert_equal([:'', :'abcdef'], m2.history)
    self.assert_equal(6, m2.appendage_length_sum)
    self.assert_equal(0, m2.char_delete_count_sum)

    count = 7
    op2 = Operation.new(type_code: TYPE_DELETE, arg: count)
    exception = self.assert_raise(CharArgumentError){Editor.perform_operation(operation: op2, model: m2)}
    self.assert_equal('1 <= count <= string length', exception.message)

    string_state = Editor.string_state(model: m2)

    self.assert_equal('abcdef', string_state)
    self.assert_equal([:''], m1.history)
    self.assert_equal(0, m1.appendage_length_sum)
    self.assert_equal(0, m1.char_delete_count_sum)
    self.assert_equal([:'', :'abcdef'], m2.history)
    self.assert_equal(6, m2.appendage_length_sum)
    self.assert_equal(0, m2.char_delete_count_sum)
  end

  def test_delete_3
    m1 = Model.new

    appendage_string = 'abcdef'
    op1 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string)
    m2 = Editor.perform_operation(operation: op1, model: m1)

    string_state1 = Editor.string_state(model: m2)
    self.assert_equal('abcdef', string_state1)

    count = 0
    op2 = Operation.new(type_code: TYPE_DELETE, arg: count)
    exception = self.assert_raise(CharArgumentError){Editor.perform_operation(operation: op2, model: m2)}
    self.assert_equal('1 <= count <= string length', exception.message)

    string_state1 = Editor.string_state(model: m2)
    self.assert_equal('abcdef', string_state1)
  end

  def test_delete_4
    m1 = Model.new

    string_state1 = Editor.string_state(model: m1)
    self.assert_equal('', string_state1)

    count = 1
    op1 = Operation.new(type_code: TYPE_DELETE, arg: count)
    exception = self.assert_raise(ArgumentError){Editor.perform_operation(operation: op1, model: m1)}
    self.assert_equal('String may not be empty', exception.message)

    string_state2 = Editor.string_state(model: m1)
    self.assert_equal('', string_state2)
  end

  def test_print_1
    m1 = Model.new

    appendage_string = 'abc'
    op1 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string)
    m2 = Editor.perform_operation(operation: op1, model: m1)

    position = 3
    op2 = Operation.new(type_code: TYPE_PRINT, arg: position)
    result = Helper.with_captured_stdout{ Editor.perform_operation(operation: op2, model: m2) }
    self.assert_equal("c\n", result)
  end

  def test_print_2
    m1 = Model.new

    appendage_string = 'abc'
    op1 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string)
    m2 = Editor.perform_operation(operation: op1, model: m1)

    position = 1
    op2 = Operation.new(type_code: TYPE_PRINT, arg: position)
    result = Helper.with_captured_stdout{ Editor.perform_operation(operation: op2, model: m2) }
    self.assert_equal("a\n", result)
  end

  def test_print_3
    m1 = Model.new

    appendage_string = 'abc'
    op1 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string)
    m2 = Editor.perform_operation(operation: op1, model: m1)

    position = 0
    op2 = Operation.new(type_code: TYPE_PRINT, arg: position)
    exception = self.assert_raise(CharArgumentError){Editor.perform_operation(operation: op2, model: m2)}
    self.assert_equal('1 <= position <= string length', exception.message)
  end

  def test_print_4
    m1 = Model.new

    appendage_string = 'abc'
    op1 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string)
    m2 = Editor.perform_operation(operation: op1, model: m1)

    position = 4
    op2 = Operation.new(type_code: TYPE_PRINT, arg: position)
    exception = self.assert_raise(CharArgumentError){Editor.perform_operation(operation: op2, model: m2)}
    self.assert_equal('1 <= position <= string length', exception.message)
  end

  def test_print_5
    m1 = Model.new

    appendage_string = ''
    op1 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string)
    m2 = Editor.perform_operation(operation: op1, model: m1)

    position = 1
    op2 = Operation.new(type_code: TYPE_PRINT, arg: position)
    exception = self.assert_raise(ArgumentError){Editor.perform_operation(operation: op2, model: m2)}
    self.assert_equal('String may not be empty', exception.message)
  end

  def test_print_6
    m1 = Model.new

    appendage_string1 = 'abc'
    op1 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string1)
    m2 = Editor.perform_operation(operation: op1, model: m1)

    appendage_string2 = 'def'
    op2 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string2)
    m3 = Editor.perform_operation(operation: op2, model: m2)

    position = 6
    op3 = Operation.new(type_code: TYPE_PRINT, arg: position)
    result = Helper.with_captured_stdout{ Editor.perform_operation(operation: op3, model: m3) }
    self.assert_equal(result, "f\n")
  end

  def test_undo
    m1 = Model.new
    self.assert_equal([:''], m1.history)
    self.assert_equal('', Editor.string_state(model: m1))

    appendage_string1 = 'a'
    op1 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string1)
    m2 = Editor.perform_operation(operation: op1, model: m1)
    self.assert_equal([:''], m1.history)
    self.assert_equal([:'', :'a'], m2.history)
    self.assert_equal('a', Editor.string_state(model: m2))

    appendage_string2 = 'b'
    op2 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string2)
    m3 = Editor.perform_operation(operation: op2, model: m2)
    self.assert_equal([:''], m1.history)
    self.assert_equal([:'', :'a'], m2.history)
    self.assert_equal([:'', :'a', :'ab'], m3.history)
    self.assert_equal('ab', Editor.string_state(model: m3))

    appendage_string3 = 'c'
    op3 = Operation.new(type_code: TYPE_APPEND, arg: appendage_string3)
    m4 = Editor.perform_operation(operation: op3, model: m3)
    self.assert_equal([:''], m1.history)
    self.assert_equal([:'', :'a'], m2.history)
    self.assert_equal([:'', :'a', :'ab'], m3.history)
    self.assert_equal([:'', :'a', :'ab', :'abc'], m4.history)
    self.assert_equal('abc', Editor.string_state(model: m4))

    op4 = Operation.new(type_code: TYPE_UNDO)
    m5 = Editor.perform_operation(operation: op4, model: m4)
    self.assert_equal([:''], m1.history)
    self.assert_equal([:'', :'a'], m2.history)
    self.assert_equal([:'', :'a', :'ab'], m3.history)
    self.assert_equal([:'', :'a', :'ab', :'abc'], m4.history)
    self.assert_equal([:'', :'a', :'ab'], m5.history)
    self.assert_equal('ab', Editor.string_state(model: m5))

    op5 = Operation.new(type_code: TYPE_UNDO)
    m6 = Editor.perform_operation(operation: op5, model: m5)
    self.assert_equal([:''], m1.history)
    self.assert_equal([:'', :'a'], m2.history)
    self.assert_equal([:'', :'a', :'ab'], m3.history)
    self.assert_equal([:'', :'a', :'ab', :'abc'], m4.history)
    self.assert_equal([:'', :'a', :'ab'], m5.history)
    self.assert_equal([:'', :'a'], m6.history)
    self.assert_equal('a', Editor.string_state(model: m6))

    op6 = Operation.new(type_code: TYPE_UNDO)
    m7 = Editor.perform_operation(operation: op6, model: m6)
    self.assert_equal([:''], m1.history)
    self.assert_equal([:'', :'a'], m2.history)
    self.assert_equal([:'', :'a', :'ab'], m3.history)
    self.assert_equal([:'', :'a', :'ab', :'abc'], m4.history)
    self.assert_equal([:'', :'a', :'ab'], m5.history)
    self.assert_equal([:'', :'a'], m6.history)
    self.assert_equal([:''], m7.history)
    self.assert_equal('', Editor.string_state(model: m7))

    op7 = Operation.new(type_code: TYPE_UNDO)
    m8 = Editor.perform_operation(operation: op7, model: m7)
    self.assert_equal([:''], m1.history)
    self.assert_equal([:'', :'a'], m2.history)
    self.assert_equal([:'', :'a', :'ab'], m3.history)
    self.assert_equal([:'', :'a', :'ab', :'abc'], m4.history)
    self.assert_equal([:'', :'a', :'ab'], m5.history)
    self.assert_equal([:'', :'a'], m6.history)
    self.assert_equal([:''], m7.history)
    self.assert_equal([:''], m8.history)
    self.assert_equal('', Editor.string_state(model: m8))
  end

end
