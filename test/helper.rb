require 'stringio'
require_relative 'constants'
require_relative '../constants'

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

  def self.generate_input_file__exceed_global_constraint__total_appendage_length_sum(filename:, generated_total_length:)
    # Assume constants as per original specification

    appendages = self.generated_mono_char_strings(
        total_length: generated_total_length,
        section_length: GENERATED_APPENDAGE_SECTION_DEFAULT_LENGTH
    )
    operation_count = appendages.length

    proc = Proc.new {|file|
      self.write_operation_count_on(file: file, count: operation_count)
      self.write_append_operations_on(file: file, appendages: appendages)
      file
    }
    self.write_on(filename: filename, proc_with_file_arg: proc)
  end

  def self.generate_input_file__exceed_global_constraint__total_char_delete_count(filename:, char_count_exceeding_limit:)
    # Assume constants as per original specification

    is_exceeding_limit = char_count_exceeding_limit > 0

    appendages = self.generated_mono_char_strings(
        total_length: TOTAL_APPENDAGE_LENGTH__UPPER_LIMIT,
        section_length: GENERATED_APPENDAGE_SECTION_DEFAULT_LENGTH
    )

    delete_operation_char_count_1 = GENERATED_APPENDAGE_SECTION_DEFAULT_LENGTH
    delete_operation_char_count_2 = delete_operation_char_count_1
    delete_operation_char_count_3 = char_count_exceeding_limit

    append_operation_count = appendages.length
    delete_operation_count_1 = append_operation_count
    undo_operation_count = delete_operation_count_1
    delete_operation_count_2 = delete_operation_count_1
    delete_operation_count_3 = is_exceeding_limit ? 1 : 0
    total_operation_count = append_operation_count + delete_operation_count_1 + undo_operation_count + delete_operation_count_2 + delete_operation_count_3

    proc = Proc.new {|file|
      self.write_operation_count_on(file: file, count: total_operation_count)

      self.write_append_operations_on(file: file, appendages: appendages)
      self.write_delete_operations_on(file: file, delete_operation_count: delete_operation_count_1, char_count: delete_operation_char_count_1)
      self.write_undo_operations_on(file: file, undo_operation_count: undo_operation_count)
      self.write_delete_operations_on(file: file, delete_operation_count: delete_operation_count_2, char_count: delete_operation_char_count_2)
      if is_exceeding_limit then
        self.write_delete_operations_on(file: file, delete_operation_count: delete_operation_count_3, char_count: delete_operation_char_count_3)
      end
      file
    }
    self.write_on(filename: filename, proc_with_file_arg: proc)
  end

  def self.generate_input_file__reach_global_constraint__operation_count_upper_limit(filename:)
    # Assume OPERATION_COUNT__UPPER_LIMIT >= 2

    operation_count = OPERATION_COUNT__UPPER_LIMIT
    is_even = operation_count.even?
    even_operation_count = is_even ? operation_count : operation_count - 1

    proc = Proc.new {|file|
      self.write_operation_count_on(file: file, count: operation_count)

      (1..((even_operation_count / 2) - 1)).each {|i|
        self.write_append_operations_on(file: file, appendages: ['c'])
        self.write_undo_operations_on(file: file, undo_operation_count: 1)
      }
      self.write_append_operations_on(file: file, appendages: ['hello'])
      self.write_print_operations_on(file: file, print_operation_count: 1, position: 5)
      self.write_print_operations_on(file: file, print_operation_count: 1, position: 5) unless is_even
      file
    }
    self.write_on(filename: filename, proc_with_file_arg: proc)
  end

  def self.write_on(filename:, proc_with_file_arg:)
    File.open(filename, "w") { |file| proc_with_file_arg.call(file)}
  end

  def self.write_operation_count_on(file:, count:)
    line = self.operation_count_line(count: count)
    file.write(line)
  end

  def self.write_append_operations_on(file:, appendages:)
    appendages.each {|a|
      line = self.append_operation_line(appendage: a)
      file.write(line)
    }
  end

  def self.write_delete_operations_on(file:, delete_operation_count:, char_count:)
    (1..delete_operation_count).each {|i|
      line = self.delete_operation_line(char_count: char_count)
      file.write(line)
    }
  end

  def self.write_print_operations_on(file:, print_operation_count:, position:)
    (1..print_operation_count).each {|i|
      line = self.print_operation_line(position: position)
      file.write(line)
    }
  end

  def self.write_undo_operations_on(file:, undo_operation_count:)
    (1..undo_operation_count).each {|i|
      line = self.undo_operation_line
      file.write(line)
    }
  end

  def self.operation_count_line(count:)
    count.to_s + "\n"
  end

  def self.append_operation_line(appendage:)
    "#{TYPE_APPEND.to_s}" + OPERATION_DELIMETER + appendage + "\n"
  end

  def self.delete_operation_line(char_count:)
    "#{TYPE_DELETE.to_s}" + OPERATION_DELIMETER + "#{char_count.to_s}\n"
  end

  def self.print_operation_line(position: position)
    "#{TYPE_PRINT.to_s}" + OPERATION_DELIMETER + "#{position.to_s}\n"
  end

  def self.undo_operation_line
    "#{TYPE_UNDO.to_s}\n"
  end

  def self.generated_mono_char_strings(total_length:, section_length:)
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

end
