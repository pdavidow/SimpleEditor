require 'test/unit'
require_relative '../editor_manager'
require_relative 'helper'

class Test_EditorManager < Test::Unit::TestCase
  include Helper

  def test_initialize
    mgr = EditorManager.new

    self.assert_equal(mgr.state, '')
  end

  def test_append_1
    mgr = EditorManager.new
    w1 = 'abC'
    mgr.append(appendage_string: w1)

    self.assert_equal(mgr.state, 'abC')

    self.assert_equal(w1, 'abC')
    w1[2] = 'q'
    self.assert_equal(w1, 'abq')
    self.assert_equal(mgr.state, 'abC')

    w2 = 'de6'
    mgr.append(appendage_string: w2)

    self.assert_equal(mgr.state, 'abCde6')
  end

  def test_append_2
    mgr = EditorManager.new
    w1 = ''

    mgr.append(appendage_string: w1)
    self.assert_equal(mgr.state, '')
  end

  def test_delete_1
    mgr = EditorManager.new
    w1 = 'abcdef'
    mgr.append(appendage_string: w1)

    self.assert_equal(mgr.state, 'abcdef')

    mgr.delete(chars_to_delete_count: 1)
    self.assert_equal(mgr.state, 'abcde')
    self.assert_equal(w1, 'abcdef')

    mgr.delete(chars_to_delete_count: 4)
    self.assert_equal(mgr.state, 'a')
    self.assert_equal(w1, 'abcdef')

    mgr.delete(chars_to_delete_count: 1)
    self.assert_equal(mgr.state, '')
    self.assert_equal(w1, 'abcdef')
  end

  def test_delete_2
    mgr = EditorManager.new
    w1 = 'abcdef'
    mgr.append(appendage_string: w1)

    exception = self.assert_raise(ArgumentError){mgr.delete(chars_to_delete_count: 0)}
    self.assert_equal('1 >= count <= string length', exception.message)

    self.assert_equal(mgr.state, 'abcdef')
  end

  def test_delete_3
    mgr = EditorManager.new
    w1 = 'abcdef'
    mgr.append(appendage_string: w1)

    exception = self.assert_raise(ArgumentError){mgr.delete(chars_to_delete_count: 7)}
    self.assert_equal('1 >= count <= string length', exception.message)

    self.assert_equal(mgr.state, 'abcdef')
  end

  def test_delete_4
    mgr = EditorManager.new

    exception = self.assert_raise(ArgumentError){mgr.delete(chars_to_delete_count: 1)}
    self.assert_equal('String may not be empty', exception.message)

    self.assert_equal(mgr.state, '')
  end

  def test_print_1
    mgr = EditorManager.new
    w1 = 'abc'
    mgr.append(appendage_string: w1)

    k = 3
    result = Helper.with_captured_stdout {mgr.print_char_at(position: k)}

    self.assert_equal(result, "c\n")

    self.assert_equal(w1, 'abc')
    self.assert_equal(k, 3)
  end

  def test_print_2
    mgr = EditorManager.new
    w1 = 'abc'
    mgr.append(appendage_string: w1)

    k = 1
    result = Helper.with_captured_stdout {mgr.print_char_at(position: k)}

    self.assert_equal(result, "a\n")

    self.assert_equal(w1, 'abc')
    self.assert_equal(k, 1)
  end

  def test_print_3
    mgr = EditorManager.new
    w1 = 'abc'
    mgr.append(appendage_string: w1)
    w2 = 'def'
    mgr.append(appendage_string: w2)

    k = 6
    result = Helper.with_captured_stdout {mgr.print_char_at(position: k)}

    self.assert_equal(result, "f\n")

    self.assert_equal(w1, 'abc')
    self.assert_equal(w2, 'def')
    self.assert_equal(k, 6)
  end

  def test_print_4
    mgr = EditorManager.new
    w1 = 'abc'
    mgr.append(appendage_string: w1)

    k = 0
    exception = self.assert_raise(ArgumentError){Helper.with_captured_stdout {mgr.print_char_at(position: k)}}
    self.assert_equal('1 >= position <= string length', exception.message)

    self.assert_equal(w1, 'abc')
    self.assert_equal(k, 0)
  end

  def test_print_5
    mgr = EditorManager.new
    w1 = 'abc'
    mgr.append(appendage_string: w1)

    k = 4
    exception = self.assert_raise(ArgumentError){Helper.with_captured_stdout {mgr.print_char_at(position: k)}}
    self.assert_equal('1 >= position <= string length', exception.message)

    self.assert_equal(w1, 'abc')
    self.assert_equal(k, 4)
  end

  def test_undo
    mgr = EditorManager.new
    self.assert_equal(mgr.state, '')

    w1 = 'abc'
    mgr.append(appendage_string: w1)
    self.assert_equal(mgr.state, 'abc')

    w2 = 'def'
    mgr.append(appendage_string: w2)
    self.assert_equal(mgr.state, 'abcdef')

    mgr.undo
    self.assert_equal(mgr.state, 'abc')

    mgr.undo
    self.assert_equal(mgr.state, '')

    mgr.undo
    self.assert_equal(mgr.state, '')

    w3 = 'ghi'
    mgr.append(appendage_string: w3)
    self.assert_equal(mgr.state, 'ghi')

    mgr.undo
    self.assert_equal(mgr.state, '')
  end
end
