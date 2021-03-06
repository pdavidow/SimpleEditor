require 'stringio'
require_relative 'constants'
require_relative '../constants'

module Helper

  def self.redirect_stdin_to_file(filename:, proc:)
    begin
      original_stdin = $stdin
      file = File.open(filename, "r")
      $stdin = file
      proc.call
    ensure
      $stdin = original_stdin
      file.close
    end
  end

  def self.with_captured_stdout
    # https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string

    original_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
    ensure
      $stdout = original_stdout
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

  def self.generate_input_file__append_delete_undo__total_appendage_length_sum(filename:)
    # Assume constants as per original specification

    section_length = 5000

    appendages = self.generated_mono_char_strings(
        total_length: APPENDAGE_LENGTH_SUM__UPPER_LIMIT,
        section_length: section_length
    )
    append_operation_count = appendages.length
    operation_count = append_operation_count * 3

    proc = Proc.new {|file|
      self.write_operation_count_on(file: file, count: operation_count)
      self.write_append_operations_on(file: file, appendages: appendages)
      self.write_delete_operations_on(file: file, delete_operation_count: append_operation_count, char_count: section_length)
      self.write_undo_operations_on(file: file, undo_operation_count: append_operation_count)
      file
    }
    self.write_on(filename: filename, proc_with_file_arg: proc)
  end

  def self.generate_input_file__exceed_global_constraint__total_char_delete_count(filename:, char_count_exceeding_limit:)
    # Assume constants as per original specification

    is_exceeding_limit = char_count_exceeding_limit > 0

    appendages = self.generated_mono_char_strings(
        total_length: APPENDAGE_LENGTH_SUM__UPPER_LIMIT,
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
      if is_exceeding_limit
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

      ((even_operation_count / 2) - 1).times {
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

  def self.generate_randomize_append_only(filename:, operation_count:, string_length:)
    proc = Proc.new {|file|
      self.write_operation_count_on(file: file, count: operation_count)

      operation_count.times {
        random_string = self.rand_string(length: string_length)
        self.write_append_operations_on(file: file, appendages: [random_string])
      }
      file
    }
    self.write_on(filename: filename, proc_with_file_arg: proc)
  end

  def self.generate_randomize_append_then_delete(filename:, operation_pair_count:, string_length:)
    proc = Proc.new {|file|
      self.write_operation_count_on(file: file, count: operation_pair_count * 2)

      operation_pair_count.times {
        random_string = self.rand_string(length: string_length)
        self.write_append_operations_on(file: file, appendages: [random_string])
      }
      self.write_delete_operations_on(file: file, delete_operation_count: operation_pair_count, char_count: string_length)
      file
    }
    self.write_on(filename: filename, proc_with_file_arg: proc)
  end

  def self.generate_randomize_append_then_undo(filename:, operation_pair_count:, string_length:)
    proc = Proc.new do |file|
      self.write_operation_count_on(file: file, count: operation_pair_count * 2)

      operation_pair_count.times {
        random_string = self.rand_string(length: string_length)
        self.write_append_operations_on(file: file, appendages: [random_string])
      }
      self.write_undo_operations_on(file: file, undo_operation_count: operation_pair_count)
      file
    end
    self.write_on(filename: filename, proc_with_file_arg: proc)
  end

  def self.generate_randomize_append_max_once_then_cycle_delete_undo(filename:, operation_pair_count:, delete_length:)
    proc = Proc.new do |file|
      self.write_operation_count_on(file: file, count: 1 + (operation_pair_count * 2))
      random_string = self.rand_string(length: APPENDAGE_LENGTH_SUM__UPPER_LIMIT)
      self.write_append_operations_on(file: file, appendages: [random_string])

      operation_pair_count.times {
        self.write_delete_operations_on(file: file, delete_operation_count: 1, char_count: delete_length)
        self.write_undo_operations_on(file: file, undo_operation_count: 1)
      }
      file
    end
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
    appendages.each do |a|
      line = self.append_operation_line(appendage: a)
      file.write(line)
    end
  end

  def self.write_delete_operations_on(file:, delete_operation_count:, char_count:)
    delete_operation_count.times do
      line = self.delete_operation_line(char_count: char_count)
      file.write(line)
    end
  end

  def self.write_print_operations_on(file:, print_operation_count:, position:)
    print_operation_count.times do
      line = self.print_operation_line(position: position)
      file.write(line)
    end
  end

  def self.write_undo_operations_on(file:, undo_operation_count:)
    undo_operation_count.times do
      line = self.undo_operation_line
      file.write(line)
    end
  end

  def self.operation_count_line(count:)
    count.to_s + "\n"
  end

  def self.append_operation_line(appendage:)
    "#{TYPE_APPEND}" + OPERATION_DELIMETER + appendage + "\n"
  end

  def self.delete_operation_line(char_count:)
    "#{TYPE_DELETE}" + OPERATION_DELIMETER + "#{char_count}\n"
  end

  def self.print_operation_line(position:)
    "#{TYPE_PRINT}" + OPERATION_DELIMETER + "#{position}\n"
  end

  def self.undo_operation_line
    "#{TYPE_UNDO}\n"
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

  def self.generated_mono_char_string(char_string: 'c', char_count:)
    string = ''
    char_count.times {string = string + char_string}
    string
  end

  def self.rand_string(length: 0)
    # https://stackoverflow.com/questions/88311/how-to-generate-a-random-string-in-ruby
    s = ''
    length.times { s << CHARS[rand(CHARS.length)] }
    s
  end

end
