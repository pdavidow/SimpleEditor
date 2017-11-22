require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../editor_exceptions'
require_relative '../sequencer'

class Test_Sequencer < Test::Unit::TestCase
  include Helper
  include Constants
  include EditorExceptions

  def test_sequence_good_1
    result = Helper.redirect_stdin_to_file_then_sequence(filename: TEST_INPUT_GOOD_FILE_NAME_1)
    self.assert_equal(result, TEST_OUTPUT_STRING_1)
  end

  ### todo: hangs system, not sure why
  # def test_sequence_good_2
  #   result = Helper.redirect_stdin_to_file_then_sequence(filename: TEST_INPUT_GOOD_FILE_NAME_4)
  #   self.assert_equal(result, TEST_OUTPUT_STRING_1)
  # end

  ### todo: hangs system, not sure why
  # def test_sequence_good_3
  #   result = Helper.redirect_stdin_to_file_then_sequence(filename: TEST_INPUT_GOOD_FILE_NAME_5)
  #   self.assert_equal(result, TEST_OUTPUT_STRING_1)
  # end

  def test_sequence_good_4
    result = Helper.redirect_stdin_to_file_then_sequence(filename: TEST_INPUT_GOOD_FILE_NAME_2)
    self.assert_equal(result, TEST_OUTPUT_STRING_2)
  end

  def test_sequence_bad_1
    exception = self.assert_raise(SequenceError){Helper.redirect_stdin_to_file_then_sequence(filename: TEST_INPUT_BAD_FILE_NAME_12)}
    self.assert_equal("Sequence error on line# 3: 1 >= count <= string length", exception.message)
  end

  def test_sequence_bad_2
    exception = self.assert_raise(FormatError){Helper.redirect_stdin_to_file_then_sequence(filename: TEST_INPUT_BAD_FILE_NAME_13)}
    self.assert_equal("Format error on line# 2: Appendage must be all lower case", exception.message)
  end

end
