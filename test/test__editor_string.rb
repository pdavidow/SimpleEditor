require 'test/unit'
require_relative '../editor_string'

class Test_EditorString < Test::Unit::TestCase

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

  def test_append_1
    s1 = "abc"
    s2 = "def"
    result = EditorString.append(baseString: s1, appendageString: s2)

    self.assert_equal("abcdef", result)

    self.assert_equal("abc", s1)
    self.assert_equal("def", s2)
  end

  def test_append_2
    s1 = "abc"
    s2 = "deF"

    exception = self.assert_raise(ArgumentError){EditorString.append(baseString: s1, appendageString: s2)}
    self.assert_equal("Appendage must be all lower case", exception.message)

    self.assert_equal("abc", s1)
    self.assert_equal("deF", s2)
  end

  def test_append_2a
    s1 = "abc"
    s2 = "de6"

    exception = self.assert_raise(ArgumentError){EditorString.append(baseString: s1, appendageString: s2)}
    self.assert_equal("Appendage must be all English letters", exception.message)

    self.assert_equal("abc", s1)
    self.assert_equal("de6", s2)
  end

  def test_append_3
    s1 = "ABC"
    s2 = "def"
    result = EditorString.append(baseString: s1, appendageString: s2)

    self.assert_equal("ABCdef", result)

    self.assert_equal("ABC", s1)
    self.assert_equal("def", s2)
  end


  def test_append_4
    s1 = "abc"
    s2 = "deF"

    exception = self.assert_raise(ArgumentError){EditorString.append(baseString: s1, appendageString: s2)}
    self.assert_equal("Appendage must be all lower case", exception.message)

    self.assert_equal("abc", s1)
    self.assert_equal("deF", s2)
  end

  def test_deleteLastChars_arg1
    s = 123
    k = 1

    exception = self.assert_raise(TypeError){EditorString.deleteLastChars(string: s, charsToDeleteCount: k)}
    self.assert_equal("string must be a String", exception.message)

    self.assert_equal(123, s)
    self.assert_equal(1, k)
  end

  def test_deleteLastChars_arg2
    s = "abc"
    k = "1"

    exception = self.assert_raise(TypeError){EditorString.deleteLastChars(string: s, charsToDeleteCount: k)}
    self.assert_equal("charsToDeleteCount must be an Integer", exception.message)

    self.assert_equal("abc", s)
    self.assert_equal("1", k)
  end

  def test_deleteLastChars_1
    s = "abcdef"
    k = 1

    result = EditorString.deleteLastChars(string: s, charsToDeleteCount: k)

    self.assert_equal("abcde", result)

    self.assert_equal("abcdef", s)
    self.assert_equal(1, k)
  end

  def test_deleteLastChars_2
    s = "abcdef"
    k = 3

    result = EditorString.deleteLastChars(string: s, charsToDeleteCount: k)

    self.assert_equal("abc", result)

    self.assert_equal("abcdef", s)
    self.assert_equal(3, k)
  end

  def test_deleteLastChars_3
    s = "abcdef"
    k = 6

    result = EditorString.deleteLastChars(string: s, charsToDeleteCount: k)

    self.assert_equal("", result)

    self.assert_equal("abcdef", s)
    self.assert_equal(6, k)
  end

  def test_deleteLastChars_4
    s = "abcdef"
    k = 0

    exception = self.assert_raise(ArgumentError){EditorString.deleteLastChars(string: s, charsToDeleteCount: k)}
    self.assert_equal("1 >= count <= string length", exception.message)

    self.assert_equal("abcdef", s)
    self.assert_equal(0, k)
  end

  def test_deleteLastChars_5
    s = "abcdef"
    k = 7

    exception = self.assert_raise(ArgumentError){EditorString.deleteLastChars(string: s, charsToDeleteCount: k)}
    self.assert_equal("1 >= count <= string length", exception.message)

    self.assert_equal("abcdef", s)
    self.assert_equal(7, k)
  end

  def test_deleteLastChars_6
    s = ""
    k = 1

    exception = self.assert_raise(ArgumentError){EditorString.deleteLastChars(string: s, charsToDeleteCount: k)}
    self.assert_equal("String may not be empty", exception.message)

    self.assert_equal("", s)
    self.assert_equal(1, k)
  end

  def test_charAtPosition_arg1
    s = 123
    k = 1

    exception = self.assert_raise(TypeError){EditorString.charAtPosition(string: s, position: k)}
    self.assert_equal("string must be a String", exception.message)

    self.assert_equal(123, s)
    self.assert_equal(1, k)
  end

  def test_charAtPosition_arg2
    s = "abc"
    k = "1"

    exception = self.assert_raise(TypeError){EditorString.charAtPosition(string: s, position: k)}
    self.assert_equal("position must be an Integer", exception.message)

    self.assert_equal("abc", s)
    self.assert_equal("1", k)
  end

  def test_charAtPosition_1
    s = "abc"
    k = 3

    result = EditorString.charAtPosition(string: s, position: k)

    self.assert_equal("c", result)

    self.assert_equal("abc", s)
    self.assert_equal(3, k)
  end

  def test_charAtPosition_2
    s = "abc"
    k = 1

    result = EditorString.charAtPosition(string: s, position: k)

    self.assert_equal("a", result)

    self.assert_equal("abc", s)
    self.assert_equal(1, k)
  end

  def test_charAtPosition_3
    s = "abc"
    k = 0

    exception = self.assert_raise(ArgumentError){EditorString.charAtPosition(string: s, position: k)}
    self.assert_equal("1 >= position <= string length", exception.message)

    self.assert_equal("abc", s)
    self.assert_equal(0, k)
  end

  def test_charAtPosition_4
    s = "abc"
    k = 4

    exception = self.assert_raise(ArgumentError){EditorString.charAtPosition(string: s, position: k)}
    self.assert_equal("1 >= position <= string length", exception.message)

    self.assert_equal("abc", s)
    self.assert_equal(4, k)
  end

  def test_charAtPosition_5
    s = ""
    k = 1

    exception = self.assert_raise(ArgumentError){EditorString.charAtPosition(string: s, position: k)}
    self.assert_equal("String may not be empty", exception.message)

    self.assert_equal("", s)
    self.assert_equal(1, k)
  end
end
