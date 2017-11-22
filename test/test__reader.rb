require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../editor_exceptions'
require_relative '../reader'

class Test_Reader < Test::Unit::TestCase
  include Constants
  include EditorExceptions

  def test_operation_count_1
    ops = Helper.redirect_stdin_to_file_then_process(filename: TEST_INPUT_GOOD_FILE_NAME_1, proc: Proc.new{Reader.read})
    self.assert_equal(8, ops.length)
  end

  def test_operation_count_2
    ops = Helper.redirect_stdin_to_file_then_process(filename: TEST_INPUT_GOOD_FILE_NAME_2, proc: Proc.new{Reader.read})
    self.assert_equal(0, ops.length)
  end

  def test_operation_count_3
    ops = Helper.redirect_stdin_to_file_then_process(filename: TEST_INPUT_GOOD_FILE_NAME_3, proc: Proc.new{Reader.read})
    self.assert_equal(8, ops.length)
  end

  ### todo: hangs system, not sure why
  # def test_operation_count_4
  #   ops = Helper.redirect_stdin_to_file_then_process(filename: TEST_INPUT_GOOD_FILE_NAME_4, proc: Proc.new{Reader.read})
  #   self.assert_equal(8, ops.length)
  # end

  ### todo: hangs system, not sure why
  # def test_operation_count_5
  #   ops = Helper.redirect_stdin_to_file_then_process(filename: TEST_INPUT_GOOD_FILE_NAME_5, proc: Proc.new{Reader.read})
  #   self.assert_equal(8, ops.length)
  # end

  def test_operation_count_6
    exception = self.assert_raise(FormatError){Helper.redirect_stdin_to_file_then_process(filename: TEST_INPUT_BAD_FILE_NAME_1, proc: Proc.new{Reader.read})}
    self.assert_equal("Format error on line# 1: Operation count must be a non_negative integer", exception.message)
  end

  #
  # def test_validation_1
  #   self.assert_raise(FormatError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_1)}
  # end
  #
  # def test_validation_2
  #   exception = self.assert_raise(FormatError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_2)}
  #   self.assert_equal("Format error on line# 1: Number of actual operations is wrong", exception.message)
  # end
  #
  # def test_validation_3
  #   exception = self.assert_raise(FormatError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_3)}
  #   self.assert_equal("Format error on line# 1: Number of actual operations is wrong", exception.message)
  # end
  #
  # def test_validation_4
  #   exception = self.assert_raise(FormatError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_4)}
  #   self.assert_equal("Format error on line# 1: Operation count expected, and must be a non_negative integer. Nothing else on the line expected.", exception.message)
  # end
  #
  # def test_validation_5
  #   exception = self.assert_raise(FormatError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_5)}
  #   self.assert_equal("Format error on line# 1: Operation count expected, and must be a non_negative integer. Nothing else on the line expected.", exception.message)
  # end
  #
  # def test_validation_6
  #   exception = self.assert_raise(FormatError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_6)}
  #   self.assert_equal("Format error on line# 1: Operation count expected, and must be a non_negative integer. Nothing else on the line expected.", exception.message)
  # end
  #
  # def test_validation_7
  #   exception = self.assert_raise(FormatError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_7)}
  #   self.assert_equal("Format error on line# 1: Operation count expected, and must be a non_negative integer. Nothing else on the line expected.", exception.message)
  # end
  #
  # def test_validation_8
  #   exception = self.assert_raise(FormatError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_8)}
  #   self.assert_equal("Format error on line# 2: Operation type must be 1, 2, 3, or 4", exception.message)
  # end
  #
  # def test_validation_9
  #   exception = self.assert_raise(FormatError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_9)}
  #   self.assert_equal("Format error on line# 2: Appendage must be all English letters", exception.message)
  # end
  #
  # def test_validation_10
  #   exception = self.assert_raise(FormatError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_10)}
  #   self.assert_equal("Format error on line# 1: Operation count expected, and must be a non_negative integer. Nothing else on the line expected.", exception.message)
  # end
  #
  # def test_validation_11
  #   exception = self.assert_raise(FormatError){Reader.new(filename: TEST_INPUT_BAD_FILE_NAME_11)}
  #   self.assert_equal("Format error on line# 1: Operation count expected, and must be a non_negative integer. Nothing else on the line expected.", exception.message)
  # end
end
