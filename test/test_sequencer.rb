require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../editor_exceptions'
require_relative '../sequencer'

class Test_Sequencer < Test::Unit::TestCase
  include Helper
  include EditorExceptions

  def test_1
    result = Helper.with_captured_stdout{ Sequencer.sequence(filename: TEST_INPUT_GOOD_FILE_NAME_1) }
    self.assert_equal(result, TEST_OUTPUT_STRING_1)
  end

  def test_2
    result = Helper.with_captured_stdout{ Sequencer.sequence(filename: TEST_INPUT_GOOD_FILE_NAME_3) }
    self.assert_equal(result, TEST_OUTPUT_STRING_1)
  end

  def test_3
    result = Helper.with_captured_stdout{ Sequencer.sequence(filename: TEST_INPUT_GOOD_FILE_NAME_4) }
    self.assert_equal(result, TEST_OUTPUT_STRING_1)
  end

  def test_4
    result = Helper.with_captured_stdout{ Sequencer.sequence(filename: TEST_INPUT_GOOD_FILE_NAME_5) }
    self.assert_equal(result, TEST_OUTPUT_STRING_1)
  end

  def test_5
    result = Helper.with_captured_stdout{ Sequencer.sequence(filename: TEST_INPUT_GOOD_FILE_NAME_6) }
    self.assert_equal(result, TEST_OUTPUT_STRING_1)
  end

  def test_6
    exception = self.assert_raise(SequenceError){Helper.with_captured_stdout{Sequencer.sequence(filename: TEST_INPUT_BAD_FILE_NAME_12)}}
    self.assert_equal("Sequence error on line# 3: 1 >= count <= string length, for current string of 'abc'", exception.message)
  end

  def test_7
    exception = self.assert_raise(SequenceError){Helper.with_captured_stdout{Sequencer.sequence(filename: TEST_INPUT_BAD_FILE_NAME_21)}}
    self.assert_equal("Sequence error on line# 4: 1 >= position <= string length, for current string of 'abcdef'", exception.message)
  end

  def test_8
    exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Sequencer.sequence(filename: TEST_INPUT_BAD_FILE_NAME_13)}}
    self.assert_equal('Format error on line# 2: Appendage must be all lower case', exception.message)
  end

  def test_9
    exception = self.assert_raise(SequenceError){Helper.with_captured_stdout{Sequencer.sequence(filename: TEST_INPUT_BAD_FILE_NAME_24)}}
    self.assert_equal('Sequence error on line# 14: String may not be empty', exception.message)
  end

end
