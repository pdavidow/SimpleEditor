require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../sequencer'

class Test_Sequencer < Test::Unit::TestCase
  include Helper

  def test_1
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_3
    Helper.generate_input_file__reach_global_constraint__operation_count_upper_limit(filename: filename)

    proc = Proc.new {
      result = Helper.with_captured_stdout{ Sequencer.sequence }
      expected = OPERATION_COUNT__UPPER_LIMIT.even? ? "o\n" : "o\no\n"
      self.assert_equal(expected, result)
    }
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)

    File.delete(filename)
  end

  def test_randomize_append_only
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_3
    proc = Proc.new {Sequencer.sequence}

    operation_count = 5
    string_length = 200000
    Helper.generate_randomize_append_only(filename: filename, operation_count: operation_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_count = 50
    string_length = 20000
    Helper.generate_randomize_append_only(filename: filename, operation_count: operation_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_count = 500
    string_length = 2000
    Helper.generate_randomize_append_only(filename: filename, operation_count: operation_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_count = 5000
    string_length = 200
    Helper.generate_randomize_append_only(filename: filename, operation_count: operation_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_count = 50000
    string_length = 20
    Helper.generate_randomize_append_only(filename: filename, operation_count: operation_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_count = 500000
    string_length = 2
    Helper.generate_randomize_append_only(filename: filename, operation_count: operation_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)
  end

  def test_randomize_append_then_delete
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_3
    proc = Proc.new {Sequencer.sequence}

    operation_pair_count = 4/2
    string_length = 200000
    Helper.generate_randomize_append_then_delete(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 50/2
    string_length = 20000
    Helper.generate_randomize_append_then_delete(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 500/2
    string_length = 2000
    Helper.generate_randomize_append_then_delete(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 5000/2
    string_length = 200
    Helper.generate_randomize_append_then_delete(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 50000/2
    string_length = 20
    Helper.generate_randomize_append_then_delete(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 500000/2
    string_length = 2
    Helper.generate_randomize_append_then_delete(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)
  end

  def test_randomize_append_then_undo
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_3
    proc = Proc.new {Sequencer.sequence}

    operation_pair_count = 4/2
    string_length = 200000
    Helper.generate_randomize_append_then_undo(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 50/2
    string_length = 20000
    Helper.generate_randomize_append_then_undo(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 500/2
    string_length = 2000
    Helper.generate_randomize_append_then_undo(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 5000/2
    string_length = 200
    Helper.generate_randomize_append_then_undo(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 50000/2
    string_length = 20
    Helper.generate_randomize_append_then_undo(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 500000/2
    string_length = 2
    Helper.generate_randomize_append_then_undo(filename: filename, operation_pair_count: operation_pair_count, string_length: string_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)
  end

  def test_randomize_append_max_once_then_cycle_delete_undo #todo
    filename = TEST_INPUT_GOOD_GENERATED_FILE_NAME_3
    proc = Proc.new {Sequencer.sequence}

    operation_pair_count = 4
    delete_length = 200000
    Helper.generate_randomize_append_max_once_then_cycle_delete_undo(filename: filename, operation_pair_count: operation_pair_count, delete_length: delete_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 49
    delete_length = 20000
    Helper.generate_randomize_append_max_once_then_cycle_delete_undo(filename: filename, operation_pair_count: operation_pair_count, delete_length: delete_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 499
    delete_length = 2000
    Helper.generate_randomize_append_max_once_then_cycle_delete_undo(filename: filename, operation_pair_count: operation_pair_count, delete_length: delete_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 4999
    delete_length = 200
    Helper.generate_randomize_append_max_once_then_cycle_delete_undo(filename: filename, operation_pair_count: operation_pair_count, delete_length: delete_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 49999
    delete_length = 20
    Helper.generate_randomize_append_max_once_then_cycle_delete_undo(filename: filename, operation_pair_count: operation_pair_count, delete_length: delete_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)

    operation_pair_count = 499999
    delete_length = 2
    Helper.generate_randomize_append_max_once_then_cycle_delete_undo(filename: filename, operation_pair_count: operation_pair_count, delete_length: delete_length)
    Helper.redirect_stdin_to_file(filename: filename, proc: proc)
    File.delete(filename)
  end

end
