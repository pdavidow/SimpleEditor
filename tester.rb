require 'test/unit'
require_relative 'editor_string'
require_relative 'editor_string_exceptions'

class Tester < Test::Unit::TestCase
  include EditorStringExceptions

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
  end

  def test_append_arg1
    s1 = 123
    s2 = "def"

    exception = self.assert_raise(TypeError){EditorString.append(baseString: s1, appendageString: s2)}
    self.assert_equal("baseString must be a String", exception.message)

    self.assert_equal(123, s1)
    self.assert_equal("def", s2)
  end

  def test_append_arg2
    s1 = "abc"
    s2 = 456

    exception = self.assert_raise(TypeError){EditorString.append(baseString: s1, appendageString: s2)}
    self.assert_equal("appendageString must be a String", exception.message)

    self.assert_equal("abc", s1)
    self.assert_equal(456, s2)
  end

  def test_append
    s1 = "abc"
    s2 = "def"
    result = EditorString.append(baseString: s1, appendageString: s2)

    self.assert_equal("abcdef", result)

    self.assert_equal("abc", s1)
    self.assert_equal("def", s2)
  end

  def test_append_upcase_1
    s1 = "abc"
    s2 = "deF"

    exception = self.assert_raise(LowerCaseError){EditorString.append(baseString: s1, appendageString: s2)}
    self.assert_equal("Appendage must be all lower case", exception.message)

    self.assert_equal("abc", s1)
    self.assert_equal("deF", s2)
  end

  def test_append_upcase_2
    s1 = "ABC"
    s2 = "def"
    result = EditorString.append(baseString: s1, appendageString: s2)

    self.assert_equal("ABCdef", result)

    self.assert_equal("ABC", s1)
    self.assert_equal("def", s2)
  end

  def test_deleteLastChars_arg1
    s = 123
    k = 1

    exception = self.assert_raise(TypeError){EditorString.deleteLastChars(string: s, charCount: k)}
    self.assert_equal("string must be a String", exception.message)

    self.assert_equal(123, s)
    self.assert_equal(1, k)
  end

  def test_deleteLastChars_arg2
    s = "abc"
    k = "1"

    exception = self.assert_raise(TypeError){EditorString.deleteLastChars(string: s, charCount: k)}
    self.assert_equal("charCount must be an Integer", exception.message)

    self.assert_equal("abc", s)
    self.assert_equal("1", k)
  end

  def test_deleteLastChars_1
    s = "abcdef"
    k = 1

    result = EditorString.deleteLastChars(string: s, charCount: k)

    self.assert_equal("abcde", result)

    self.assert_equal("abcdef", s)
    self.assert_equal(1, k)
  end

  def test_deleteLastChars_2
    s = "abcdef"
    k = 3

    result = EditorString.deleteLastChars(string: s, charCount: k)

    self.assert_equal("abc", result)

    self.assert_equal("abcdef", s)
    self.assert_equal(3, k)
  end

  def test_deleteLastChars_3
    s = "abcdef"
    k = 6

    result = EditorString.deleteLastChars(string: s, charCount: k)

    self.assert_equal("", result)

    self.assert_equal("abcdef", s)
    self.assert_equal(6, k)
  end

  def test_deleteLastChars_4
    s = "abcdef"
    k = 0

    exception = self.assert_raise(CharCountOutOfBoundsError){EditorString.deleteLastChars(string: s, charCount: k)}
    self.assert_equal("1 >= charCount <= string length", exception.message)

    self.assert_equal("abcdef", s)
    self.assert_equal(0, k)
  end

  def test_deleteLastChars_5
    s = "abcdef"
    k = 7

    exception = self.assert_raise(CharCountOutOfBoundsError){EditorString.deleteLastChars(string: s, charCount: k)}
    self.assert_equal("1 >= charCount <= string length", exception.message)

    self.assert_equal("abcdef", s)
    self.assert_equal(7, k)
  end

  def test_deleteLastChars_6
    s = ""
    k = 1

    exception = self.assert_raise(EmptyStringError){EditorString.deleteLastChars(string: s, charCount: k)}
    self.assert_equal("String may not be empty", exception.message)

    self.assert_equal("", s)
    self.assert_equal(1, k)
  end
end

