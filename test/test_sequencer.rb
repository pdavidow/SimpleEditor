require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../editor_exceptions'
require_relative '../sequencer'
require_relative '../editor_manager'

class Test_Sequencer < Test::Unit::TestCase
  include Helper
  include Constants
  include EditorExceptions

  def test_sequence_1
    sequencer = Sequencer.new(inputFilename: TEST_INPUT_GOOD_FILE_NAME_1)
    editorManager = EditorManager.new

    result = withCapturedStdout {sequencer.sequence()}
    self.assert_equal(result, TEST_OUTPUT_STRING_1)
  end

  def test_sequence_2
    sequencer = Sequencer.new(inputFilename: TEST_INPUT_GOOD_FILE_NAME_2)

    result = withCapturedStdout {sequencer.sequence}
    self.assert_equal(result, TEST_OUTPUT_STRING_2)
  end

  def test_sequence_3
    sequencer = Sequencer.new(inputFilename: TEST_INPUT_BAD_FILE_NAME_12)

    exception = self.assert_raise(SequenceError){sequencer.sequence}
    self.assert_equal("Sequence error on line# 3: 1 >= count <= string length", exception.message)
  end

  def test_sequence_4
    sequencer = Sequencer.new(inputFilename: TEST_INPUT_BAD_FILE_NAME_13)

    exception = self.assert_raise(FormatError){sequencer.sequence}
    self.assert_equal("Format error on line# 2: Appendage must be all lower case", exception.message)
  end
end