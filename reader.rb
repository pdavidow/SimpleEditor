require_relative 'input_line'
require_relative 'helper'

class Reader
  include Helper

  def self.read_operation_count
    line_number = 1

    begin
      string = $stdin.readline
      InputLine.operation_count_from(line_number: line_number, string: string)
    rescue EOFError
      Helper.raise_format_error(line_number: line_number, error: 'Operation count expected')
    end
  end

  def self.read_operation(line_number:)
    begin
      string = $stdin.readline
      InputLine.operation_from(line_number: line_number, string: string)
    rescue EOFError
      Helper.raise_format_error(line_number: line_number, error: 'Operation expected')
    end
  end

  #########################################################################################
# todo
  private_class_method def self.validate_global_constraint__total_appendage_length_sum(operations:)
    sum = self.sum_length_appendages(operations: operations)
    if sum > APPENDAGE_LENGTH_SUM__UPPER_LIMIT then
      Helper.raise__global_constraint__error(error: "The sum of the lengths of all appendage arguments (for operation type #{TYPE_APPEND.to_s}) must be <= #{APPENDAGE_LENGTH_SUM__UPPER_LIMIT.to_s}, but instead is #{sum}")
    end
  end

  private_class_method def self.validate_global_constraint__total_char_delete_count(operations: operations)
    count = self.total_char_delete_count(operations: operations)
    if count > TOTAL_CHAR_DELETE_COUNT__UPPER_LIMIT then
      Helper.raise__global_constraint__error(error: "The total char delete count (for operation type #{TYPE_DELETE}) must be <= #{TOTAL_CHAR_DELETE_COUNT__UPPER_LIMIT}, but instead is #{count}")
    end
  end

end



