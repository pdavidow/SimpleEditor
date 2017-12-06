require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../sequencer'

class Test_Sequencer < Test::Unit::TestCase
  include Helper

  def test_1
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_3
    Helper.generate_input_file__reach_global_constraint__OPERATION_COUNT__UPPER_LIMIT(filename: filename)

    proc = Proc.new {
      result = Helper.with_captured_stdout{ Sequencer.sequence }
      expected = OPERATION_COUNT__UPPER_LIMIT.even? ? "o\n" : "o\no\n"
      self.assert_equal(expected, result)
    }
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)

    File.delete(filename)
  end


  def test_2
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_4
    Helper.generate_randomize_input_file__reach_global_constraint__APPENDAGE_LENGTH_SUM__UPPER_LIMIT(filename: filename)

    proc = Proc.new {
      Sequencer.sequence
    }
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)

    File.delete(filename)
  end

end
