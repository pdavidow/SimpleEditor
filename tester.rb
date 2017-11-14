require 'test/unit'
require_relative 'editor_string'


class Tester < Test::Unit::TestCase
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
end
