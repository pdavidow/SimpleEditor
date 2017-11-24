require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../editor_exceptions'
require_relative '../reader'

class Test_Reader < Test::Unit::TestCase
  include EditorExceptions

  def test_1
    ops = Reader.read(filename: TEST_INPUT_GOOD_FILE_NAME_1)
    self.assert_equal(8, ops.length)
  end

  def test_3
    ops = Reader.read(filename: TEST_INPUT_GOOD_FILE_NAME_3)
    self.assert_equal(8, ops.length)
  end

  def test_4
    ops = Reader.read(filename: TEST_INPUT_GOOD_FILE_NAME_4)
    self.assert_equal(8, ops.length)
  end

  def test_5
    ops = Reader.read(filename: TEST_INPUT_GOOD_FILE_NAME_5)
    self.assert_equal(8, ops.length)
  end

  def test_6
    exception = self.assert_raise(FormatError){Reader.read(filename:  TEST_INPUT_BAD_FILE_NAME_1)}
    self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
  end

  def test_7
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_3)}
    self.assert_equal('Format error on line# 5: Operation expected', exception.message)
  end

  def test_8
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_4)}
    self.assert_equal('Format error on line# 1: Operation count expected, and nothing else', exception.message)
  end

  def test_9
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_5)}
    self.assert_equal('Format error on line# 1: Operation count expected', exception.message)
  end

  def test_10
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_6)}
    self.assert_equal('Format error on line# 1: Operation count expected', exception.message)
  end

  def test_11
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_7)}
    self.assert_equal('Format error on line# 1: Operation count expected', exception.message)
  end

  def test_12
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_8)}
    self.assert_equal('Format error on line# 2: Operation type must be 1, 2, 3, or 4', exception.message)
  end

  def test_13a
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_9)}
    self.assert_equal('Format error on line# 2: Appendage must be all English letters', exception.message)
  end

  def test_13b
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_13)}
    self.assert_equal('Format error on line# 2: Appendage must be all lower case', exception.message)
  end

  def test_14
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_10)}
    self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
  end

  def test_15
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_11)}
    self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
  end

  def test_16
    # Sequencer -- not Reader -- error
    ops = Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_12)
    self.assert_equal(2, ops.length)
  end

  def test_17
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_14)}
    self.assert_equal('Format error on line# 3: No argument expected for operation type 4', exception.message)
  end

  def test_18
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_15)}
    self.assert_equal('Format error on line# 2: Argument expected for operation type 1', exception.message)
  end

  def test_19
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_16)}
    self.assert_equal('Format error on line# 2: Argument expected for operation type 2', exception.message)
  end

  def test_20
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_17)}
    self.assert_equal('Format error on line# 2: Argument expected for operation type 3', exception.message)
  end

  def test_21
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_18)}
    self.assert_equal('Format error on line# 2: Operation expected', exception.message)
  end

  def test_22
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_19)}
    self.assert_equal('Format error on line# 2: Char count must be positive integer', exception.message)
  end

  def test_23
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_20)}
    self.assert_equal('Format error on line# 2: Char position must be positive integer', exception.message)
  end

  def test_24
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_22)}
    self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
  end

  def test_25
    exception = self.assert_raise(FormatError){Reader.read(filename: TEST_INPUT_BAD_FILE_NAME_23)}
    self.assert_equal('Format error on line# 1: Operation count must be a positive integer <= 1000000', exception.message)
  end

  def test_26
    filename = TEST_INPUT_BAD_GENERATED_FILE_NAME_1
    Helper.generate_input_file__exceed_global_constraint__total_appendage_length_sum(
        filename: filename,
        generated_total_length: TOTAL_APPENDAGE_LENGTH__UPPER_LIMIT + 1)

    exception = self.assert_raise(GlobalConstraintError){Reader.read(filename: filename)}
    self.assert_equal('The sum of the lengths of all appendage arguments (for operation type 1) must be <= 1000000, but instead is 1000001', exception.message)

    File.delete(filename)
  end

  def test_27
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_1
    Helper.generate_input_file__exceed_global_constraint__total_appendage_length_sum(
        filename: filename,
        generated_total_length: TOTAL_APPENDAGE_LENGTH__UPPER_LIMIT)

    ops = Reader.read(filename: filename)
    self.assert_equal(TOTAL_APPENDAGE_LENGTH__UPPER_LIMIT, Reader.sum_length_appendages(operations: ops))

    File.delete(filename)
  end

  def test_28
    filename = TEST_INPUT_BAD_GENERATED_FILE_NAME_2
    Helper.generate_input_file__exceed_global_constraint__total_char_delete_count(
        filename: filename,
        char_count_exceeding_limit: 1
    )

    exception = self.assert_raise(GlobalConstraintError){Reader.read(filename: filename)}
    self.assert_equal('The total char delete count (for operation type 2) must be <= 2000000, but instead is 2000001', exception.message)

    File.delete(filename)
  end

  def test_29
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_2
    Helper.generate_input_file__exceed_global_constraint__total_char_delete_count(
        filename: filename,
        char_count_exceeding_limit: 0
    )

    ops = Reader.read(filename: filename)
    self.assert_equal(TOTAL_CHAR_DELETE_COUNT__UPPER_LIMIT, Reader.total_char_delete_count(operations: ops))

    File.delete(filename)
  end

end
