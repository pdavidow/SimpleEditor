require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../editor_exceptions'
require_relative '../scanner'

class Test_Scanner < Test::Unit::TestCase
  include Helper
  include EditorExceptions

  def test_1
    proc = Proc.new do
      result = Helper.with_captured_stdout{ Scanner.scan }
      self.assert_equal("c\ny\na\n", result)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_GOOD_FILE_NAME_1, proc: proc)
  end

  def test_2
    proc = Proc.new do
      result = Helper.with_captured_stdout{ Scanner.scan }
      self.assert_equal("c\ny\na\n", result)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_GOOD_FILE_NAME_3, proc: proc)
  end

  def test_3
    proc = Proc.new do
      result = Helper.with_captured_stdout{ Scanner.scan }
      self.assert_equal("c\ny\na\n", result)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_GOOD_FILE_NAME_4, proc: proc)
  end

  def test_4
    proc = Proc.new do
      result = Helper.with_captured_stdout{ Scanner.scan }
      self.assert_equal("c\ny\na\n", result)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_GOOD_FILE_NAME_5, proc: proc)
  end

  def test_5
    proc = Proc.new do
      result = Helper.with_captured_stdout{ Scanner.scan }
      self.assert_equal("c\ny\na\n", result)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_GOOD_FILE_NAME_6, proc: proc)
  end


  def test_6
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_1, proc: proc)
  end

  def test_7
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 5: Operation expected', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_3, proc: proc)
  end

  def test_8
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 1: Operation count expected, and nothing else', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_4, proc: proc)
  end

  def test_9
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 1: Operation count expected', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_5, proc: proc)
  end

  def test_10
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 1: Operation count expected', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_6, proc: proc)
  end

  def test_11
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 1: Operation count expected', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_7, proc: proc)
  end

  def test_12
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 2: Operation type must be 1, 2, 3, or 4', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_8, proc: proc)
  end

  def test_13
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 2: Appendage must be all English letters', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_9, proc: proc)
  end

  def test_14
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_10, proc: proc)
  end

  def test_15
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_11, proc: proc)
  end

  def test_16
    proc = Proc.new do
      exception = self.assert_raise(SequenceError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal("Sequence error on line# 3: 1 <= count <= string length. Current string is 'abc'", exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_12, proc: proc)
  end

  def test_17
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 2: Appendage must be all lower case', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_13, proc: proc)
  end

  def test_18
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 3: No argument expected for operation type 4', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_14, proc: proc)
  end

  def test_19
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 2: Argument expected for operation type 1', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_15, proc: proc)
  end

  def test_20
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 2: Argument expected for operation type 2', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_16, proc: proc)
  end

  def test_21
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 2: Argument expected for operation type 3', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_17, proc: proc)
  end

  def test_22
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 2: Operation expected', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_18, proc: proc)
  end

  def test_23
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 2: Char count must be positive integer', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_19, proc: proc)
  end

  def test_24
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 2: Char position must be positive integer', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_20, proc: proc)
  end

  def test_25
    proc = Proc.new do
      exception = self.assert_raise(SequenceError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal("Sequence error on line# 4: 1 <= position <= string length. Current string is 'abcdef'", exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_21, proc: proc)
  end

  def test_26
    proc = Proc.new do
      exception = self.assert_raise(FormatError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Format error on line# 1: Operation count must be a positive integer', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_22, proc: proc)
  end

  def test_27
    proc = Proc.new do
      exception = self.assert_raise(GlobalConstraintError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal("Global Constraint error on line# 1: Operation count must be a positive integer <= #{OPERATION_COUNT__UPPER_LIMIT.to_s}", exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_23, proc: proc)
  end

  def test_28
    proc = Proc.new do
      exception = self.assert_raise(SequenceError){Helper.with_captured_stdout{Scanner.scan}}
      self.assert_equal('Sequence error on line# 14: String may not be empty', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: TEST_INPUT_BAD_FILE_NAME_24, proc: proc)
  end

  def test_29
    filename = TEST_INPUT_BAD_GENERATED_FILE_NAME_1
    Helper.generate_input_file__exceed_global_constraint__total_appendage_length_sum(
        filename: filename,
        generated_total_length: APPENDAGE_LENGTH_SUM__UPPER_LIMIT + 1)

    proc = Proc.new do
      exception = self.assert_raise(GlobalConstraintError){Scanner.scan}
      self.assert_equal("Global Constraint error on line# 202: The sum of the lengths of all appendage arguments (for operation type 1) must be <= #{OPERATION_COUNT__UPPER_LIMIT.to_s}, but instead is #{(OPERATION_COUNT__UPPER_LIMIT + 1).to_s}", exception.message)
    end
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)

    File.delete(filename)
  end

  def test_30
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_1
    Helper.generate_input_file__append_delete_undo__total_appendage_length_sum(filename: filename)

    proc = Proc.new {Scanner.scan} # test that undo delete (which is an append) does _not_ affect appendage summation
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)

    File.delete(filename)
  end

  def test_31
    filename = TEST_INPUT_BAD_GENERATED_FILE_NAME_1
    Helper.generate_input_file__exceed_global_constraint__total_char_delete_count(
        filename: filename,
        char_count_exceeding_limit: 1
    )

    proc = Proc.new do
      exception = self.assert_raise(GlobalConstraintError){Scanner.scan}
      self.assert_equal('Global Constraint error on line# 802: The total char delete count (for operation type 2) must be <= 2000000, but instead is 2000001', exception.message)
    end
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)

    File.delete(filename)
  end

end