require 'test/unit'
require_relative '../editor'
require_relative '../editor_exceptions'
require_relative 'helper'

class Test_Editor < Test::Unit::TestCase
  include Helper
  include EditorExceptions

  def test_append_1
    m1 = Editor.initial_model

    appendage_string1 = 'ab3'
    op1 = {type_code: TYPE_APPEND, arg: appendage_string1}
    m2 = Editor.perform_operation(operation: op1, model: m1)

    self.assert_equal('ab3', m2[:string])
    self.assert_equal([], m1[:undos])
    self.assert_equal(0, m1[:appendage_length_sum])
    self.assert_equal(0, m1[:char_delete_count_sum])
    self.assert_equal([TYPE_UNDO_APPEND], m2[:undos].map{|op| op[:type_code]})
    self.assert_equal(3, m2[:appendage_length_sum])
    self.assert_equal(0, m2[:char_delete_count_sum])

    appendage_string2 = 'deF'
    op2 = {type_code: TYPE_APPEND, arg: appendage_string2}
    m3 = Editor.perform_operation(operation: op2, model: m2)

    self.assert_equal('ab3deF', m3[:string])
    self.assert_equal([], m1[:undos])
    self.assert_equal(0, m1[:appendage_length_sum])
    self.assert_equal(0, m1[:char_delete_count_sum])
    self.assert_equal([TYPE_UNDO_APPEND], m2[:undos].map{|op| op[:type_code]})
    self.assert_equal(3, m2[:appendage_length_sum])
    self.assert_equal(0, m2[:char_delete_count_sum])
    self.assert_equal([TYPE_UNDO_APPEND, TYPE_UNDO_APPEND], m3[:undos].map{|op| op[:type_code]})
    self.assert_equal(6, m3[:appendage_length_sum])
    self.assert_equal(0, m3[:char_delete_count_sum])
  end

  def test_delete_1
    m1 = Editor.initial_model

    appendage_string1 = 'abcdef'
    op1 = {type_code: TYPE_APPEND, arg: appendage_string1}
    m2 = Editor.perform_operation(operation: op1, model: m1)

    self.assert_equal('abcdef', m2[:string])
    self.assert_equal([], m1[:undos])
    self.assert_equal(0, m1[:appendage_length_sum])
    self.assert_equal(0, m1[:char_delete_count_sum])
    self.assert_equal([TYPE_UNDO_APPEND], m2[:undos].map{|op| op[:type_code]})
    self.assert_equal(6, m2[:appendage_length_sum])
    self.assert_equal(0, m2[:char_delete_count_sum])

    count1 = 1
    op2 = {type_code: TYPE_DELETE, arg: count1}
    m3 = Editor.perform_operation(operation: op2, model: m2)

    self.assert_equal('abcde', m3[:string])
    self.assert_equal([], m1[:undos])
    self.assert_equal(0, m1[:appendage_length_sum])
    self.assert_equal(0, m1[:char_delete_count_sum])
    self.assert_equal([TYPE_UNDO_APPEND], m2[:undos].map{|op| op[:type_code]})
    self.assert_equal(6, m2[:appendage_length_sum])
    self.assert_equal(0, m2[:char_delete_count_sum])
    self.assert_equal([TYPE_UNDO_APPEND, TYPE_UNDO_DELETE], m3[:undos].map{|op| op[:type_code]})
    self.assert_equal(6, m3[:appendage_length_sum])
    self.assert_equal(1, m3[:char_delete_count_sum])

    count2 = 5
    op3 = {type_code: TYPE_DELETE, arg: count2}
    m4 = Editor.perform_operation(operation: op3, model: m3)

    self.assert_equal('', m4[:string])
    self.assert_equal([], m1[:undos])
    self.assert_equal(0, m1[:appendage_length_sum])
    self.assert_equal(0, m1[:char_delete_count_sum])
    self.assert_equal([TYPE_UNDO_APPEND], m2[:undos].map{|op| op[:type_code]})
    self.assert_equal(6, m2[:appendage_length_sum])
    self.assert_equal(0, m2[:char_delete_count_sum])
    self.assert_equal([TYPE_UNDO_APPEND, TYPE_UNDO_DELETE], m3[:undos].map{|op| op[:type_code]})
    self.assert_equal(6, m3[:appendage_length_sum])
    self.assert_equal(1, m3[:char_delete_count_sum])
    self.assert_equal([TYPE_UNDO_APPEND, TYPE_UNDO_DELETE, TYPE_UNDO_DELETE], m4[:undos].map{|op| op[:type_code]})
    self.assert_equal(6, m4[:appendage_length_sum])
    self.assert_equal(6, m4[:char_delete_count_sum])
  end

  def test_delete_2
    m1 = Editor.initial_model

    appendage_string1 = 'abcdef'
    op1 = {type_code: TYPE_APPEND, arg: appendage_string1}
    m2 = Editor.perform_operation(operation: op1, model: m1)
    self.assert_equal('abcdef', m2[:string])

    count = 7
    op2 = {type_code: TYPE_DELETE, arg: count}
    exception = self.assert_raise(CharArgumentError){Editor.perform_operation(operation: op2, model: m2)}
    self.assert_equal('1 <= count <= string length', exception.message)
    self.assert_equal('abcdef', m2[:string])
  end

  def test_delete_3
    m1 = Editor.initial_model

    appendage_string1 = 'abcdef'
    op1 = {type_code: TYPE_APPEND, arg: appendage_string1}
    m2 = Editor.perform_operation(operation: op1, model: m1)
    self.assert_equal('abcdef', m2[:string])

    count = 0
    op2 = {type_code: TYPE_DELETE, arg: count}
    exception = self.assert_raise(CharArgumentError){Editor.perform_operation(operation: op2, model: m2)}
    self.assert_equal('1 <= count <= string length', exception.message)
    self.assert_equal('abcdef', m2[:string])
  end

  def test_delete_4
    m1 = Editor.initial_model

    self.assert_equal('', m1[:string])

    count = 1
    op1 = {type_code: TYPE_DELETE, arg: count}
    exception = self.assert_raise(ArgumentError){Editor.perform_operation(operation: op1, model: m1)}
    self.assert_equal('String may not be empty', exception.message)
    self.assert_equal('', m1[:string])
  end

  def test_print_1
    m1 = Editor.initial_model

    appendage_string1 = 'abc'
    op1 = {type_code: TYPE_APPEND, arg: appendage_string1}
    m2 = Editor.perform_operation(operation: op1, model: m1)

    position = 3
    op2 = {type_code: TYPE_PRINT, arg: position}
    result = Helper.with_captured_stdout{ Editor.perform_operation(operation: op2, model: m2) }
    self.assert_equal("c\n", result)
  end

  def test_print_2
    m1 = Editor.initial_model

    appendage_string1 = 'abc'
    op1 = {type_code: TYPE_APPEND, arg: appendage_string1}
    m2 = Editor.perform_operation(operation: op1, model: m1)

    position = 1
    op2 = {type_code: TYPE_PRINT, arg: position}
    result = Helper.with_captured_stdout{ Editor.perform_operation(operation: op2, model: m2) }
    self.assert_equal("a\n", result)
  end

  def test_print_3
    m1 = Editor.initial_model

    appendage_string = 'abc'
    op1 = {type_code: TYPE_APPEND, arg: appendage_string}
    m2 = Editor.perform_operation(operation: op1, model: m1)

    position = 0
    op2 = {type_code: TYPE_PRINT, arg: position}
    exception = self.assert_raise(CharArgumentError){Editor.perform_operation(operation: op2, model: m2)}
    self.assert_equal('1 <= position <= string length', exception.message)
  end

  def test_print_4
    m1 = Editor.initial_model

    appendage_string = 'abc'
    op1 = {type_code: TYPE_APPEND, arg: appendage_string}
    m2 = Editor.perform_operation(operation: op1, model: m1)

    position = 4
    op2 = {type_code: TYPE_PRINT, arg: position}
    exception = self.assert_raise(CharArgumentError){Editor.perform_operation(operation: op2, model: m2)}
    self.assert_equal('1 <= position <= string length', exception.message)
  end

  def test_print_5
    m1 = Editor.initial_model

    appendage_string = ''
    op1 = {type_code: TYPE_APPEND, arg: appendage_string}
    m2 = Editor.perform_operation(operation: op1, model: m1)

    position = 1
    op2 = {type_code: TYPE_PRINT, arg: position}
    exception = self.assert_raise(ArgumentError){Editor.perform_operation(operation: op2, model: m2)}
    self.assert_equal('String may not be empty', exception.message)
  end

  def test_print_6
    m1 = Editor.initial_model

    appendage_string1 = 'abc'
    op1 = {type_code: TYPE_APPEND, arg: appendage_string1}
    m2 = Editor.perform_operation(operation: op1, model: m1)

    appendage_string2 = 'def'
    op2 = {type_code: TYPE_APPEND, arg: appendage_string2}
    m3 = Editor.perform_operation(operation: op2, model: m2)

    position = 6
    op3 = {type_code: TYPE_PRINT, arg: position}
    result = Helper.with_captured_stdout{ Editor.perform_operation(operation: op3, model: m3) }
    self.assert_equal(result, "f\n")
  end


  def test_undo
    m1 = Editor.initial_model
    self.assert_equal([], m1[:undos].map{|op| op.type_code})

    appendage_string1 = 'a'
    op1 = {type_code: TYPE_APPEND, arg: appendage_string1}
    m2 = Editor.perform_operation(operation: op1, model: m1)
    self.assert_equal([TYPE_UNDO_APPEND], m2[:undos].map{|op| op[:type_code]})

    appendage_string2 = 'b'
    op2 = {type_code: TYPE_APPEND, arg: appendage_string2}
    m3 = Editor.perform_operation(operation: op2, model: m2)
    self.assert_equal([TYPE_UNDO_APPEND, TYPE_UNDO_APPEND], m3[:undos].map{|op| op[:type_code]})

    appendage_string3 = 'c'
    op3 = {type_code: TYPE_APPEND, arg: appendage_string3}
    m4 = Editor.perform_operation(operation: op3, model: m3)
    self.assert_equal([TYPE_UNDO_APPEND, TYPE_UNDO_APPEND, TYPE_UNDO_APPEND], m4[:undos].map{|op| op[:type_code]})
    self.assert_equal('abc', m4[:string])

    op4 = {type_code: TYPE_UNDO}
    m5 = Editor.perform_operation(operation: op4, model: m4)
    self.assert_equal([TYPE_UNDO_APPEND, TYPE_UNDO_APPEND], m5[:undos].map{|op| op[:type_code]})
    self.assert_equal('ab', m5[:string])

    op5 = {type_code: TYPE_UNDO}
    m6 = Editor.perform_operation(operation: op5, model: m5)
    self.assert_equal([TYPE_UNDO_APPEND], m6[:undos].map{|op| op[:type_code]})
    self.assert_equal('a', m6[:string])

    op6 = {type_code: TYPE_UNDO}
    m7 = Editor.perform_operation(operation: op6, model: m6)
    self.assert_equal([], m7[:undos].map{|op| op[:type_code]})
    self.assert_equal('', m7[:string])

    op7 = {type_code: TYPE_UNDO}
    m8 = Editor.perform_operation(operation: op7, model: m7)
    self.assert_equal([], m8[:undos].map{|op| op[:type_code]})
    self.assert_equal('', m8[:string])
  end
end
