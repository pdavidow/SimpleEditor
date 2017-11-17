require 'test/unit'
require_relative '../reader'
require_relative 'helper'

class Tester_Reader < Test::Unit::TestCase

  # TEST_INPUT_FILE_NAME = '../test/input.txt' ### doesn't work, so keep in main dir for now
  TEST_INPUT_GOOD_FILE_NAME = 'input_good.txt'
  TEST_INPUT_BAD_FILE_NAME = 'input_bad.txt'

  def test_lines
    reader = Reader.new(filename: TEST_INPUT_GOOD_FILE_NAME)
    lines = reader.lines()

    self.assert_equal(9, lines.length())

    self.assert_equal("8\n", lines[0])
    self.assert_equal("3 1", lines[8])
  end

  def test_operationCount_1
    reader = Reader.new(filename: TEST_INPUT_GOOD_FILE_NAME)
    count = reader.operationCount()

    self.assert_equal(8, count)
  end

  def test_operationCount_2
    reader = Reader.new(filename: TEST_INPUT_BAD_FILE_NAME)
    self.assert_raise(ArgumentError){reader.operationCount()}
  end

end


