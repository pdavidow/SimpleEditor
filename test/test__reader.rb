require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../editor_exceptions'
require_relative '../reader'

class Test_Reader < Test::Unit::TestCase
  include Constants
  include EditorExceptions

  # def test_1
  #   ops = Reader.read(filename: TEST_INPUT_GOOD_FILE_NAME_1)
  #   self.assert_equal(8, ops.length)
  # end
  #
  # def test_3
  #   ops = Reader.read(filename: TEST_INPUT_GOOD_FILE_NAME_3)
  #   self.assert_equal(8, ops.length)
  # end
  #
  # def test_4
  #   ops = Reader.read(filename: TEST_INPUT_GOOD_FILE_NAME_4)
  #   self.assert_equal(8, ops.length)
  # end
  #
  # def test_5
  #   ops = Reader.read(filename: TEST_INPUT_GOOD_FILE_NAME_5)
  #   self.assert_equal(8, ops.length)
  # end
  #
  # def test_6
  #   exception = self.assert_raise(FormatError){Reader.read(filename:  TEST_INPUT_BAD_FILE_NAME_1)}
  #   self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
  # end
  #
  # def test_7
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_3)}
  #   self.assert_equal('Format error on line# 5: Operation expected', exception.message)
  # end
  #
  # def test_8
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_4)}
  #   self.assert_equal('Format error on line# 1: Operation count expected, and nothing else', exception.message)
  # end
  #
  # def test_9
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_5)}
  #   self.assert_equal('Format error on line# 1: Operation count expected', exception.message)
  # end
  #
  # def test_10
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_6)}
  #   self.assert_equal('Format error on line# 1: Operation count expected', exception.message)
  # end
  #
  # def test_11
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_7)}
  #   self.assert_equal('Format error on line# 1: Operation count expected', exception.message)
  # end
  #
  # def test_12
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_8)}
  #   self.assert_equal('Format error on line# 2: Operation type must be 1, 2, 3, or 4', exception.message)
  # end
  #
  # def test_13a
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_9)}
  #   self.assert_equal('Format error on line# 2: Appendage must be all English letters', exception.message)
  # end
  #
  # def test_13b
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_13)}
  #   self.assert_equal('Format error on line# 2: Appendage must be all lower case', exception.message)
  # end
  #
  # def test_14
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_10)}
  #   self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
  # end
  #
  # def test_15
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_11)}
  #   self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
  # end
  #
  # def test_16
  #   # Sequencer -- not Reader -- error
  #   ops = Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_12)
  #   self.assert_equal(2, ops.length)
  # end
  #
  # def test_17
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_14)}
  #   self.assert_equal('Format error on line# 3: No argument expected for operation type 4', exception.message)
  # end
  #
  # def test_18
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_15)}
  #   self.assert_equal('Format error on line# 2: Argument expected for operation type 1', exception.message)
  # end
  #
  # def test_19
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_16)}
  #   self.assert_equal('Format error on line# 2: Argument expected for operation type 2', exception.message)
  # end
  #
  # def test_20
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_17)}
  #   self.assert_equal('Format error on line# 2: Argument expected for operation type 3', exception.message)
  # end
  #
  # def test_21
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_18)}
  #   self.assert_equal('Format error on line# 2: Operation expected', exception.message)
  # end
  #
  # def test_22
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_19)}
  #   self.assert_equal('Format error on line# 2: Char count must be positive integer', exception.message)
  # end
  #
  # def test_23
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_20)}
  #   self.assert_equal('Format error on line# 2: Char position must be positive integer', exception.message)
  # end
  #
  # def test_24
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_22)}
  #   self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
  # end
  #
  # def test_25
  #   exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_23)}
  #   self.assert_equal('Format error on line# 1: Operation count must be a positive integer <= 1000000', exception.message)
  # end

  def test_26
    filename = TEST_INPUT_BAD_GENERATED_FILE_NAME_1
    Helper.generate_input_file__exceed_global_constraint__total_appendage_length_sum(filename: filename)

    exception = self.assert_raise(GlobalConstraintError){Reader.read(filename: filename)}
    self.assert_equal('The sum of the lengths of all appendage arguments (for operation type 1) <= 1000000', exception.message)
  end

end