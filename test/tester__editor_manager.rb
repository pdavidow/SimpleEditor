require 'test/unit'
require_relative '../editor_manager'
require_relative '../editor_string_exceptions'

class Tester_EditorManager < Test::Unit::TestCase
  include EditorStringExceptions

  def test_initialize
    mgr = EditorManager.new()

    self.assert_equal(mgr.s(), "")
  end

  def test_append_1
    mgr = EditorManager.new()
    w1 = "abc"
    mgr.append(w: w1)

    self.assert_equal(mgr.s(), "abc")

    w1[2] = "q"
    self.assert_equal(w1, "abq")
    self.assert_equal(mgr.s(), "abc")

    w2 = "def"
    mgr.append(w: w2)

    self.assert_equal(mgr.s(), "abcdef")
  end

  def test_append_2
    mgr = EditorManager.new()
    w1 = "abC"

    exception = self.assert_raise(LowerCaseError){mgr.append(w: w1)}
    self.assert_equal("Appendage must be all lower case", exception.message)

    self.assert_equal(mgr.s(), "")
  end

  def test_delete_1
    mgr = EditorManager.new()
    w1 = "abcdef"
    mgr.append(w: w1)

    self.assert_equal(mgr.s(), "abcdef")

    mgr.delete(k: 1)
    self.assert_equal(mgr.s(), "abcde")

    mgr.delete(k: 4)
    self.assert_equal(mgr.s(), "a")

    mgr.delete(k: 1)
    self.assert_equal(mgr.s(), "")
  end

  def test_delete_2
    mgr = EditorManager.new()
    w1 = "abcdef"
    mgr.append(w: w1)

    exception = self.assert_raise(CharCountOutOfBoundsError){mgr.delete(k: 0)}
    self.assert_equal("1 >= char count <= string length", exception.message)

    self.assert_equal(mgr.s(), "abcdef")
  end

  def test_delete_3
    mgr = EditorManager.new()
    w1 = "abcdef"
    mgr.append(w: w1)

    exception = self.assert_raise(CharCountOutOfBoundsError){mgr.delete(k: 7)}
    self.assert_equal("1 >= char count <= string length", exception.message)

    self.assert_equal(mgr.s(), "abcdef")
  end

  def test_delete_4
    mgr = EditorManager.new()

    exception = self.assert_raise(EmptyStringError){mgr.delete(k: 1)}
    self.assert_equal("String may not be empty", exception.message)

    self.assert_equal(mgr.s(), "")
  end

  def test_undo
    mgr = EditorManager.new()
    self.assert_equal(mgr.s(), "")

    w1 = "abc"
    mgr.append(w: w1)
    self.assert_equal(mgr.s(), "abc")

    w2 = "def"
    mgr.append(w: w2)
    self.assert_equal(mgr.s(), "abcdef")

    mgr.undo()
    self.assert_equal(mgr.s(), "abc")

    mgr.undo()
    self.assert_equal(mgr.s(), "")

    mgr.undo()
    self.assert_equal(mgr.s(), "")

    w3 = "ghi"
    mgr.append(w: w3)
    self.assert_equal(mgr.s(), "ghi")

    mgr.undo()
    self.assert_equal(mgr.s(), "")
  end
end

