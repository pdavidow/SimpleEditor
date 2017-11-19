require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../sequencer'

class Test_Sequencer < Test::Unit::TestCase
  include Helper
  include Constants

  def test_sequence_1
    seqr = Sequencer.new(inputFilename: TEST_INPUT_GOOD_FILE_NAME_1)

    result = withCapturedStdout {seqr.sequence()}
    self.assert_equal(result, TEST_OUTPUT_STRING_1)
  end

  def test_sequence_2
    seqr = Sequencer.new(inputFilename: TEST_INPUT_GOOD_FILE_NAME_2)

    result = withCapturedStdout {seqr.sequence()}
    self.assert_equal(result, TEST_OUTPUT_STRING_2)
  end
end