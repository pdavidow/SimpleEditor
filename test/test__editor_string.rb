require 'test/unit'
require_relative '../editor_string'
require_relative '../editor_exceptions'

class Test_EditorString < Test::Unit::TestCase
  include EditorExceptions

  def test_append_arg1
    s1 = 123
    s2 = 'def'

    exception = self.assert_raise(TypeError){EditorString.append(base_string: s1, appendage_string: s2)}
    self.assert_equal('base_string must be a string', exception.message)

    self.assert_equal(123, s1)
    self.assert_equal('def', s2)
  end

  def test_append_arg2
    s1 = 'abc'
    s2 = 456

    exception = self.assert_raise(TypeError){EditorString.append(base_string: s1, appendage_string: s2)}
    self.assert_equal('appendage_string must be a string', exception.message)

    self.assert_equal('abc', s1)
    self.assert_equal(456, s2)
  end

  def test_append_1
    s1 = 'abc'
    s2 = 'def'
    result = EditorString.append(base_string: s1, appendage_string: s2)

    self.assert_equal('abcdef', result)

    self.assert_equal('abc', s1)
    self.assert_equal('def', s2)
  end

  def test_append_2
    s1 = 'ABC'
    s2 = 'def'
    result = EditorString.append(base_string: s1, appendage_string: s2)

    self.assert_equal('ABCdef', result)

    self.assert_equal('ABC', s1)
    self.assert_equal('def', s2)
  end

  def test_delete_last_chars_arg1
    s = 123
    k = 1

    exception = self.assert_raise(TypeError){EditorString.delete_last_chars(string: s, chars_to_delete_count: k)}
    self.assert_equal('String must be a string', exception.message)

    self.assert_equal(123, s)
    self.assert_equal(1, k)
  end

  def test_delete_last_chars_arg2
    s = 'abc'
    k = '1'

    exception = self.assert_raise(TypeError){EditorString.delete_last_chars(string: s, chars_to_delete_count: k)}
    self.assert_equal('Count must be an integer', exception.message)

    self.assert_equal('abc', s)
    self.assert_equal('1', k)
  end

  def test_delete_last_chars_1
    s = 'abcdef'
    k = 1

    result = EditorString.delete_last_chars(string: s, chars_to_delete_count: k)

    self.assert_equal('abcde', result)

    self.assert_equal('abcdef', s)
    self.assert_equal(1, k)
  end

  def test_delete_last_chars_2
    s = 'abcdef'
    k = 3

    result = EditorString.delete_last_chars(string: s, chars_to_delete_count: k)

    self.assert_equal('abc', result)

    self.assert_equal('abcdef', s)
    self.assert_equal(3, k)
  end

  def test_delete_last_chars_3
    s = 'abcdef'
    k = 6

    result = EditorString.delete_last_chars(string: s, chars_to_delete_count: k)

    self.assert_equal('', result)

    self.assert_equal('abcdef', s)
    self.assert_equal(6, k)
  end

  def test_delete_last_chars_4
    s = 'abcdef'
    k = 0

    exception = self.assert_raise(CharArgumentError){EditorString.delete_last_chars(string: s, chars_to_delete_count: k)}
    self.assert_equal('1 <= count <= string length', exception.message)

    self.assert_equal('abcdef', s)
    self.assert_equal(0, k)
  end

  def test_delete_last_chars_5
    s = 'abcdef'
    k = 7

    exception = self.assert_raise(CharArgumentError){EditorString.delete_last_chars(string: s, chars_to_delete_count: k)}
    self.assert_equal('1 <= count <= string length', exception.message)

    self.assert_equal('abcdef', s)
    self.assert_equal(7, k)
  end

  def test_delete_last_chars_6
    s = ''
    k = 1

    exception = self.assert_raise(ArgumentError){EditorString.delete_last_chars(string: s, chars_to_delete_count: k)}
    self.assert_equal('String may not be empty', exception.message)

    self.assert_equal('', s)
    self.assert_equal(1, k)
  end

  def test_char_at_position_arg1
    s = 123
    k = 1

    exception = self.assert_raise(TypeError){EditorString.char_at_position(string: s, position: k)}
    self.assert_equal('String must be a string', exception.message)

    self.assert_equal(123, s)
    self.assert_equal(1, k)
  end

  def test_char_at_position_arg2
    s = 'abc'
    k = '1'

    exception = self.assert_raise(TypeError){EditorString.char_at_position(string: s, position: k)}
    self.assert_equal('Position must be an integer', exception.message)

    self.assert_equal('abc', s)
    self.assert_equal('1', k)
  end

  def test_char_at_position_1
    s = 'abc'
    k = 3

    result = EditorString.char_at_position(string: s, position: k)

    self.assert_equal('c', result)

    self.assert_equal('abc', s)
    self.assert_equal(3, k)
  end

  def test_char_at_position_2
    s = 'abc'
    k = 1

    result = EditorString.char_at_position(string: s, position: k)

    self.assert_equal('a', result)

    self.assert_equal('abc', s)
    self.assert_equal(1, k)
  end

  def test_char_at_position_3
    s = 'abc'
    k = 0

    exception = self.assert_raise(CharArgumentError){EditorString.char_at_position(string: s, position: k)}
    self.assert_equal('1 <= position <= string length', exception.message)

    self.assert_equal('abc', s)
    self.assert_equal(0, k)
  end

  def test_char_at_position_4
    s = 'abc'
    k = 4

    exception = self.assert_raise(CharArgumentError){EditorString.char_at_position(string: s, position: k)}
    self.assert_equal('1 <= position <= string length', exception.message)

    self.assert_equal('abc', s)
    self.assert_equal(4, k)
  end

  def test_char_at_position_5
    s = ''
    k = 1

    exception = self.assert_raise(ArgumentError){EditorString.char_at_position(string: s, position: k)}
    self.assert_equal('String may not be empty', exception.message)

    self.assert_equal('', s)
    self.assert_equal(1, k)
  end
end