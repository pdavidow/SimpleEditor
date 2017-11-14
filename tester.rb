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
  end

  def test_append_upcase_2
    s1 = "ABC"
    s2 = "def"
    result = EditorString.append(baseString: s1, appendageString: s2)

    self.assert_equal("ABCdef", result)
    self.assert_equal("ABC", s1)
    self.assert_equal("def", s2)
  end
end
