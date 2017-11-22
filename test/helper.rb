require 'stringio'
# todo DELLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
module Helper

  def self.with_captured_stdout
    # https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string

    old_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end

  def self.redirect_stdin_to_file_then_process(filename:, proc:)
    begin
      file = STDIN.reopen(filename, "r")
      result = proc.call
    ensure
      file.close
    end
    result
  end

  def self.redirect_stdin_to_file_then_sequence(filename:)
    self.redirect_stdin_to_file_then_process(
        filename: filename,
        proc: Proc.new{self.with_captured_stdout {Sequencer.sequence}}
    )
  end



  ### hangs system, don't use ################################################# todo
  def self.redirect_stdin_to_string_then_process(string:, proc:)
    #old_stdin = $stdin
    $stdin = StringIO.new(string)
    result = proc.call
    #$stdin = old_stdin
    #result
  end

  def self.redirect_stdin_to_string_then_sequence(string:)
    self.redirect_stdin_to_string_then_process(
        string: string,
        proc: Proc.new{self.with_captured_stdout {Sequencer.sequence}}
    )
  end
  ##############################################################################

  # todo have containgin method that handles file lifecycle , use proc...
  def self.generate_input_file__exceed_global_constraint__total_appendage_length_sum(filename:)
    appendages = self.generated_mono_char_strings(total_length: 1 + TOTAL_APPENDAGE_SUM_LENGTH_UPPER_LIMIT)
    self.operaton_input_file_on(filename: filename, appendages: appendages)
  end

  def self.operaton_input_file_on(filename:, appendages:)
    file = File.open(filename, "w") {|f|
      operation_count_line = operation_count_line(count: appendages.length)
      f.write(operation_count_line)

      appendages.each {|a|
        operation_line = self.append_operation_line(appendage: a)
        f.write(operation_line)
      }
    }
    file
  end

  def self.operation_count_line(count:)
    count.to_s + "\n"
  end

  def self.append_operation_line(appendage:)
    "1 " + appendage + "\n"
  end

  def self.generated_mono_char_strings(total_length:, section_length: section_length = 5000)
    return self.generated_mono_char_string(char_count: total_length) if total_length < section_length

    array = []
    current_sum_length = 0

    while current_sum_length < total_length
      remaining_length = total_length - current_sum_length

      char_count = remaining_length >= section_length ? section_length : remaining_length
      string = self.generated_mono_char_string(char_count: char_count)
      array.push(string)
      current_sum_length = current_sum_length + string.length
    end

    array
  end

  def self.generated_mono_char_string(char: char_string = 'c', char_count:)
    string = ''
    (1..char_count).each {|i| string = string + char_string}
    string
  end

  #File.delete(TEST_OUTPUT_FILE_NAME) if File.exists?(TEST_OUTPUT_FILE_NAME)

  def self.output_to_file_named(filename, strings)
    file = File.open(filename, "w") {|f|
      strings.each {|s|
        f.write(s)
      }
    }
    file
  end

  #############File.delete(TEST_INPUT_BAD_GENERATED_FILE_NAME_1) if File.exists?(TEST_INPUT_BAD_GENERATED_FILE_NAME_1)
end
