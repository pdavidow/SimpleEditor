require 'test/unit'
require_relative '../operation'
require_relative '../input_line'
require_relative '../editor_exceptions'

class Test_Operation < Test::Unit::TestCase
  include EditorExceptions

  def test_parseLine_1
    op = Operation.new(inputLine: InputLine.new(string:"1 abc\n"))

    self.assert_equal(1, op.typeCode)
    self.assert_equal("abc", op.arg)
  end

  def test_parseLine_2
    op = Operation.new(inputLine: InputLine.new(string:"2 3\n"))

    self.assert_equal(2, op.typeCode)
    self.assert_equal(3, op.arg)
  end

  def test_parseLine_3
    op = Operation.new(inputLine: InputLine.new(string:"3 2\n"))

    self.assert_equal(3, op.typeCode)
    self.assert_equal(2, op.arg)
  end


  def test_parseLine_4
    op = Operation.new(inputLine: InputLine.new(string:"4\n"))

    self.assert_equal(4, op.typeCode)
    self.assert_equal(nil, op.arg)
  end

  def test_parseLine_5
    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"0\n", number: 3))}
    self.assert_equal("Format error on line# 3: Operation type must be 1, 2, 3, or 4", exception.message)

    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"5\n"))}
    self.assert_equal("Format error on line# 0: Operation type must be 1, 2, 3, or 4", exception.message)

    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"33\n"))}
    self.assert_equal("Format error on line# 0: Operation type must be 1, 2, 3, or 4", exception.message)

    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"3.0\n"))}
    self.assert_equal("Format error on line# 0: Operation type must be 1, 2, 3, or 4", exception.message)

    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"-1 abc\n"))}
    self.assert_equal("Format error on line# 0: Operation type must be 1, 2, 3, or 4", exception.message)

    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"a\n"))}
    self.assert_equal("Format error on line# 0: Operation type must be 1, 2, 3, or 4", exception.message)
  end

  def test_parseLine_6
    self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"2 a\n"))}
    self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"3 a\n"))}
  end

  def test_parseLine_7
    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:""))}
    self.assert_equal("Format error on line# 0: Operation type expected", exception.message)

    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"\n"))}
    self.assert_equal("Format error on line# 0: Operation type expected", exception.message)
  end

  def test_parseLine_8
    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"1\n"))}
    self.assert_equal("Format error on line# 0: Argument expected for operation type 1", exception.message)

    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"2\n"))}
    self.assert_equal("Format error on line# 0: Argument expected for operation type 2", exception.message)

    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"3\n"))}
    self.assert_equal("Format error on line# 0: Argument expected for operation type 3", exception.message)
  end

  def test_parseLine_9
    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"1 abC\n", number: 1))}
    self.assert_equal("Format error on line# 1: Appendage must be all lower case", exception.message)
  end

  def test_parseLine_10
    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"1 ab3\n"))}
    self.assert_equal("Format error on line# 0: Appendage must be all English letters", exception.message)

    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"1 ab&\n"))}
    self.assert_equal("Format error on line# 0: Appendage must be all English letters", exception.message)

    exception = self.assert_raise(FormatError){Operation.new(inputLine: InputLine.new(string:"1 ab.\n"))}
    self.assert_equal("Format error on line# 0: Appendage must be all English letters", exception.message)
  end
end