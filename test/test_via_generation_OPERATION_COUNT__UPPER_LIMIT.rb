require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../editor_exceptions'
require_relative '../sequencer'

class Test_Sequencer < Test::Unit::TestCase
  include Helper
  include EditorExceptions

  def test_1
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_3
    Helper.generate_input_file__reach_global_constraint__operation_count_upper_limit(filename: filename)

    ops = Reader.read(filename: filename)
    self.assert_equal(OPERATION_COUNT__UPPER_LIMIT, ops.length)

    result = Helper.with_captured_stdout{ Sequencer.sequence(filename: filename) }
    expected = OPERATION_COUNT__UPPER_LIMIT.even? ? "o\n" : "o\no\n"
    self.assert_equal(expected, result)

    File.delete(filename)
  end

end
