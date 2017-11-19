require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../reader'

class Test_Reader < Test::Unit::TestCase
  include Constants

  def test_lines
    reader = Reader.new(filename: TEST_INPUT_GOOD_FILE_NAME_1)
    lines = reader.lines()

    self.assert_equal(9, lines.length())

    self.assert_equal("8\n", lines[0].string)
    self.assert_equal("3 1", lines[8].string)
  end

  def test_operationCount
    reader = Reader.new(filename: TEST_INPUT_GOOD_FILE_NAME_1)
    count = reader.operationCount()

    self.assert_equal(8, count)
  end

  def test_operationCount_actual_1
    reader = Reader.new(filename: TEST_INPUT_GOOD_FILE_NAME_1)
    count = reader.operationLines.length()

    self.assert_equal(8, count)
  end

  def test_operationCount_actual_2
    reader = Reader.new(filename: TEST_INPUT_GOOD_FILE_NAME_2)
    count = reader.operationLines.length()

    self.assert_equal(0, count)
  end

  def test_validation_1
    self.assert_raise(ArgumentError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_1)}
  end

  def test_validation_2
    exception = self.assert_raise(ScriptError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_2)}
    self.assert_equal("Number of actual operations is wrong", exception.message)
  end

  def test_validation_3
    exception = self.assert_raise(ScriptError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_3)}
    self.assert_equal("Number of actual operations is wrong", exception.message)
  end

  def test_validation_4
    self.assert_raise(ArgumentError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_4)}
  end

  def test_validation_5
    self.assert_raise(ArgumentError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_5)}
  end

  def test_validation_6
    self.assert_raise(ArgumentError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_6)}
  end

  def test_validation_7
    self.assert_raise(ArgumentError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_7)}
  end

  def test_validation_8
    exception = self.assert_raise(TypeError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_8)}
    self.assert_equal("Type must be 1, 2, 3, or 4", exception.message)
  end

  def test_validation_9
    self.assert_raise(ArgumentError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_9)}
  end

  def test_validation_10
    exception = self.assert_raise(ArgumentError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_10)}
    self.assert_equal("Operation count must be a non-negative integer", exception.message)
  end

  def test_validation_11
    exception = self.assert_raise(ArgumentError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_11)}
    self.assert_equal("Operation count must be a non-negative integer", exception.message)
  end
end


