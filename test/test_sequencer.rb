require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../editor_exceptions'
require_relative '../sequencer'

class Test_Sequencer < Test::Unit::TestCase
  include Helper
  include EditorExceptions

  def test_1
    proc = Proc.new {
      result = Helper.with_captured_stdout{ Sequencer.sequence }
      self.assert_equal("c\ny\na\n", result)
    }
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_GOOD_FILE_NAME_1, proc: proc)
  end

  def test_2
    proc = Proc.new {
      result = Helper.with_captured_stdout{ Sequencer.sequence }
      self.assert_equal("c\ny\na\n", result)
    }
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_GOOD_FILE_NAME_3, proc: proc)
  end

  def test_3
    proc = Proc.new {
      result = Helper.with_captured_stdout{ Sequencer.sequence }
      self.assert_equal("c\ny\na\n", result)
    }
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_GOOD_FILE_NAME_4, proc: proc)
  end

  def test_4
    proc = Proc.new {
      result = Helper.with_captured_stdout{ Sequencer.sequence }
      self.assert_equal("c\ny\na\n", result)
    }
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_GOOD_FILE_NAME_5, proc: proc)
  end

  def test_5
    proc = Proc.new {
      result = Helper.with_captured_stdout{ Sequencer.sequence }
      self.assert_equal("c\ny\na\n", result)
    }
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_GOOD_FILE_NAME_6, proc: proc)
  end

  def test_6
    proc = Proc.new {
      exception = self.assert_raise(SequenceError){Helper.with_captured_stdout{Sequencer.sequence}}
      self.assert_equal("Sequence error on line# 3: 1 >= count <= string length. Current string is 'abc'", exception.message)
    }
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_12, proc: proc)
  end

  def test_7
    proc = Proc.new {
      exception = self.assert_raise(SequenceError){Helper.with_captured_stdout{Sequencer.sequence}}
      self.assert_equal("Sequence error on line# 4: 1 >= position <= string length. Current string is 'abcdef'", exception.message)
    }
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_21, proc: proc)
  end

  def test_8
    proc = Proc.new {
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Sequencer.sequence}}
      self.assert_equal('Format error on line# 2: Appendage must be all lower case', exception.message)
    }
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_13, proc: proc)
  end

  def test_9
    proc = Proc.new {
      exception = self.assert_raise(SequenceError){Helper.with_captured_stdout{Sequencer.sequence}}
      self.assert_equal('Sequence error on line# 14: String may not be empty', exception.message)
    }
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_24, proc: proc)
  end

end
