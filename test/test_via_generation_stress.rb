require 'test/unit'
require_relative 'helper'
require_relative 'constants'
require_relative '../sequencer'

=begin

DIED on test_randomize_append_only for
    operation_count = 500000
    string_length = 2

C:/Users/Trader/RubymineProjects/HackerRank/history_manager.rb:29:in `push': failed to allocate memory (NoMemoryError)
	from C:/Users/Trader/RubymineProjects/HackerRank/history_manager.rb:29:in `add_state'
	from C:/Users/Trader/RubymineProjects/HackerRank/history_manager.rb:24:in `add_string_state'
from C:/Users/Trader/RubymineProjects/HackerRank/editor.rb:33:in `append'
	from C:/Users/Trader/RubymineProjects/HackerRank/editor.rb:12:in `perform_operation'
	from C:/Users/Trader/RubymineProjects/HackerRank/sequencer.rb:18:in `block in sequence'
from C:/Users/Trader/RubymineProjects/HackerRank/sequencer.rb:15:in `each'
	from C:/Users/Trader/RubymineProjects/HackerRank/sequencer.rb:15:in `sequence'
	from C:/Users/Trader/RubymineProjects/HackerRank/test/test_via_generation_stress.rb:25:in `block in test_randomize_append_only'
from C:/Users/Trader/RubymineProjects/HackerRank/test/helper.rb:12:in `redirect_stdin_to_file'
	from C:/Users/Trader/RubymineProjects/HackerRank/test/test_via_generation_stress.rb:60:in `test_randomize_append_only'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/testcase.rb:764:in `run_test'
from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/testcase.rb:479:in `block (2 levels) in run'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/fixture.rb:270:in `block in create_fixtures_runner'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/fixture.rb:270:in `block in create_fixtures_runner'
from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/fixture.rb:251:in `run_fixture'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/fixture.rb:286:in `run_setup'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/testcase.rb:477:in `block in run'
from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/testcase.rb:476:in `catch'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/testcase.rb:476:in `run'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/testsuite.rb:124:in `run_test'
from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/testsuite.rb:53:in `run'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/testsuite.rb:124:in `run_test'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/testsuite.rb:53:in `run'
from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/ui/testrunnermediator.rb:67:in `run_suite'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/ui/testrunnermediator.rb:45:in `block (2 levels) in run'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/ui/testrunnermediator.rb:102:in `with_listener'
from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/ui/testrunnermediator.rb:41:in `block in run'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/ui/testrunnermediator.rb:39:in `catch'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/ui/testrunnermediator.rb:39:in `run'
from (eval):12:in `run'
	from C:/Program Files/JetBrains/RubyMine 2017.2.4/rb/testing/patch/testunit/test/unit/ui/teamcity/testrunner.rb:93:in `start_mediator'
	from C:/Program Files/JetBrains/RubyMine 2017.2.4/rb/testing/patch/testunit/test/unit/ui/teamcity/testrunner.rb:81:in `start'
from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/ui/testrunnerutilities.rb:24:in `run'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/autorunner.rb:438:in `block in run'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/autorunner.rb:494:in `change_work_directory'
from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/autorunner.rb:437:in `run'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit/autorunner.rb:62:in `run'
	from C:/Ruby24-x64/lib/ruby/gems/2.4.0/gems/test-unit-3.2.3/lib/test/unit.rb:502:in `block (2 levels) in <top (required)>'

1 tests, 1 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications

Test suite finished: 622.041371 seconds

Process finished with exit code 1

=end

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

end
