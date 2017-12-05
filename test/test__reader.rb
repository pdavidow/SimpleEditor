require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../editor_exceptions'
require_relative '../reader'

class Test_Reader < Test::Unit::TestCase
  include EditorExceptions



  def test_26
    filename = TEST_INPUT_BAD_GENERATED_FILE_NAME_1
    Helper.generate_input_file__exceed_global_constraint__total_appendage_length_sum(
        filename: filename,
        generated_total_length: TOTAL_APPENDAGE_LENGTH__UPPER_LIMIT + 1)

    proc = Proc.new {
      exception = self.assert_raise(GlobalConstraintError){Reader.read}
      self.assert_equal("The sum of the lengths of all appendage arguments (for operation type 1) must be <= #{OPERATION_COUNT__UPPER_LIMIT.to_s}, but instead is #{(OPERATION_COUNT__UPPER_LIMIT + 1).to_s}", exception.message)
    }
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)

    File.delete(filename)
  end

  def test_27
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_1
    Helper.generate_input_file__exceed_global_constraint__total_appendage_length_sum(
        filename: filename,
        generated_total_length: TOTAL_APPENDAGE_LENGTH__UPPER_LIMIT)

    proc = Proc.new {
      ops = Reader.read
      self.assert_equal(TOTAL_APPENDAGE_LENGTH__UPPER_LIMIT, Reader.sum_length_appendages(operations: ops))
    }
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)

    File.delete(filename)
  end

  def test_28
    filename = TEST_INPUT_BAD_GENERATED_FILE_NAME_2
    Helper.generate_input_file__exceed_global_constraint__total_char_delete_count(
        filename: filename,
        char_count_exceeding_limit: 1
    )

    proc = Proc.new {
      exception = self.assert_raise(GlobalConstraintError){Reader.read}
      self.assert_equal('The total char delete count (for operation type 2) must be <= 2000000, but instead is 2000001', exception.message)
    }
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)

    File.delete(filename)
  end

  def test_29
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_2
    Helper.generate_input_file__exceed_global_constraint__total_char_delete_count(
        filename: filename,
        char_count_exceeding_limit: 0
    )

    proc = Proc.new {
      ops = Reader.read
      self.assert_equal(TOTAL_CHAR_DELETE_COUNT__UPPER_LIMIT, Reader.total_char_delete_count(operations: ops))
    }
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)

    File.delete(filename)
  end

end
