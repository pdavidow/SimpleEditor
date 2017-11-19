require 'test/unit'
require_relative '../editor_manager'
require_relative 'helper'

class Test_EditorManager < Test::Unit::TestCase
  include Helper

  def test_initialize
    mgr = EditorManager.new()

    self.assert_equal(mgr.s(), "")
  end

  def test_append_1
    mgr = EditorManager.new()
    w1 = "abc"
    mgr.append(w: w1)

    self.assert_equal(mgr.s(), "abc")

    self.assert_equal(w1, "abc")
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

    exception = self.assert_raise(ArgumentError){mgr.append(w: w1)}
    self.assert_equal("Appendage must be all lower case", exception.message)

    self.assert_equal(mgr.s(), "")
  end

  def test_append_3
    mgr = EditorManager.new()
    w1 = "ab3"

    exception = self.assert_raise(ArgumentError){mgr.append(w: w1)}
    self.assert_equal("Appendage must be all English letters", exception.message)

    self.assert_equal(mgr.s(), "")
  end

  def test_append_4
    mgr = EditorManager.new()
    w1 = ""

    exception = self.assert_raise(ArgumentError){mgr.append(w: w1)}
    self.assert_equal("Appendage must be all English letters", exception.message)

    self.assert_equal(mgr.s(), "")
  end

  def test_delete_1
    mgr = EditorManager.new()
    w1 = "abcdef"
    mgr.append(w: w1)

    self.assert_equal(mgr.s(), "abcdef")

    mgr.delete(k: 1)
    self.assert_equal(mgr.s(), "abcde")
    self.assert_equal(w1, "abcdef")

    mgr.delete(k: 4)
    self.assert_equal(mgr.s(), "a")
    self.assert_equal(w1, "abcdef")

    mgr.delete(k: 1)
    self.assert_equal(mgr.s(), "")
    self.assert_equal(w1, "abcdef")
  end

  def test_delete_2
    mgr = EditorManager.new()
    w1 = "abcdef"
    mgr.append(w: w1)

    exception = self.assert_raise(ArgumentError){mgr.delete(k: 0)}
    self.assert_equal("1 >= count <= string length", exception.message)

    self.assert_equal(mgr.s(), "abcdef")
  end

  def test_delete_3
    mgr = EditorManager.new()
    w1 = "abcdef"
    mgr.append(w: w1)

    exception = self.assert_raise(ArgumentError){mgr.delete(k: 7)}
    self.assert_equal("1 >= count <= string length", exception.message)

    self.assert_equal(mgr.s(), "abcdef")
  end

  def test_delete_4
    mgr = EditorManager.new()

    exception = self.assert_raise(ArgumentError){mgr.delete(k: 1)}
    self.assert_equal("String may not be empty", exception.message)

    self.assert_equal(mgr.s(), "")
  end

  def test_print_1
    mgr = EditorManager.new()
    w1 = "abc"
    mgr.append(w: w1)

    k = 3
    result = withCapturedStdout {mgr.printCharAt(k: k)}

    self.assert_equal(result, "c\n")

    self.assert_equal(w1, "abc")
    self.assert_equal(k, 3)
  end

  def test_print_2
    mgr = EditorManager.new()
    w1 = "abc"
    mgr.append(w: w1)

    k = 1
    result = withCapturedStdout {mgr.printCharAt(k: k)}

    self.assert_equal(result, "a\n")

    self.assert_equal(w1, "abc")
    self.assert_equal(k, 1)
  end

  def test_print_3
    mgr = EditorManager.new()
    w1 = "abc"
    mgr.append(w: w1)
    w2 = "def"
    mgr.append(w: w2)

    k = 6
    result = withCapturedStdout {mgr.printCharAt(k: k)}

    self.assert_equal(result, "f\n")

    self.assert_equal(w1, "abc")
    self.assert_equal(w2, "def")
    self.assert_equal(k, 6)
  end

  def test_print_4
    mgr = EditorManager.new()
    w1 = "abc"
    mgr.append(w: w1)

    k = 0
    exception = self.assert_raise(ArgumentError){withCapturedStdout {mgr.printCharAt(k: k)}}
    self.assert_equal("1 >= position <= string length", exception.message)

    self.assert_equal(w1, "abc")
    self.assert_equal(k, 0)
  end

  def test_print_5
    mgr = EditorManager.new()
    w1 = "abc"
    mgr.append(w: w1)

    k = 4
    exception = self.assert_raise(ArgumentError){withCapturedStdout {mgr.printCharAt(k: k)}}
    self.assert_equal("1 >= position <= string length", exception.message)

    self.assert_equal(w1, "abc")
    self.assert_equal(k, 4)
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

