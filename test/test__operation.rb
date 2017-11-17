require 'test/unit'
require_relative '../operation'

class Test_Operation < Test::Unit::TestCase

  def test_parseLine_1
    op = Operation.new(line: "1 abc\n")

    self.assert_equal(1, op.typeCode())
    self.assert_equal("abc", op.arg())
  end

  def test_parseLine_2
    op = Operation.new(line: "2 3\n")

    self.assert_equal(2, op.typeCode())
    self.assert_equal(3, op.arg())
  end

  def test_parseLine_3
    op = Operation.new(line: "3 2\n")

    self.assert_equal(3, op.typeCode())
    self.assert_equal(2, op.arg())
  end


  def test_parseLine_4
    op = Operation.new(line: "4\n")

    self.assert_equal(4, op.typeCode())
    self.assert_equal(nil, op.arg())
  end

  def test_parseLine_5
    exception = self.assert_raise(TypeError){Operation.new(line: "0\n")}
    self.assert_equal("Type must be 1, 2, 3, or 4", exception.message)

    exception = self.assert_raise(TypeError){Operation.new(line: "5\n")}
    self.assert_equal("Type must be 1, 2, 3, or 4", exception.message)

    exception = self.assert_raise(TypeError){Operation.new(line: "33\n")}
    self.assert_equal("Type must be 1, 2, 3, or 4", exception.message)

    exception = self.assert_raise(TypeError){Operation.new(line: "-1 abc\n")}
    self.assert_equal("Type must be 1, 2, 3, or 4", exception.message)
  end

  def test_parseLine_6
    self.assert_raise(ArgumentError){Operation.new(line: "3.0\n")}
    self.assert_raise(ArgumentError){Operation.new(line: "a\n")}
  end

  def test_parseLine_7
    self.assert_raise(ArgumentError){Operation.new(line: "2 a\n")}
    self.assert_raise(ArgumentError){Operation.new(line: "3 a\n")}
  end

  def test_parseLine_8
    exception = self.assert_raise(ArgumentError){Operation.new(line: "1\n")}
    self.assert_equal("Arg expected", exception.message)

    exception = self.assert_raise(ArgumentError){Operation.new(line: "2\n")}
    self.assert_equal("Arg expected", exception.message)

    exception = self.assert_raise(ArgumentError){Operation.new(line: "3\n")}
    self.assert_equal("Arg expected", exception.message)
  end

  def test_parseLine_9
    exception = self.assert_raise(ArgumentError){Operation.new(line: "1 abC\n")}
    self.assert_equal("Appendage must be all lower case", exception.message)
  end
end
