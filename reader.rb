require_relative 'input_line'

class Reader

  def self.read(filename:)
    file = File.new(filename)

    count = self.read_operation_count(file: file)
    operations = self.read_operations(file: file, operation_count: count)

    self.validate_global_constraints(operations: operations)
    operations
  end

  def self.read_operation_count(file:)
    line_number = 1

    begin
      InputLine.operation_count_from(line_number: line_number, string: file.readline)
    rescue EOFError
      Helper.raise_format_error(line_number: line_number, error: 'Operation count expected')
    end
  end

  def self.read_operations(file:, operation_count:)
    (2..(operation_count + 1)).map {|line_number|
      begin
        InputLine.operation_from(line_number: line_number, string: file.readline)
      rescue EOFError
        Helper.raise_format_error(line_number: line_number, error: 'Operation expected')
      end
    }
  end

  def self.validate_global_constraints(operations:)
    self.validate_global_constraint__total_appendage_length_sum(operations: operations)
    self.validate_global_constraint__total_char_delete_count(operations: operations)
  end

  def self.validate_global_constraint__total_appendage_length_sum(operations:)
    sum = self.sum_length_appendages(operations: operations)
    if sum > TOTAL_APPENDAGE_LENGTH_UPPER_LIMIT then
      Helper.raise__global_constraint__error(error: "The sum of the lengths of all appendage arguments (for operation type #{TYPE_APPEND.to_s}) must be <= #{TOTAL_APPENDAGE_LENGTH_UPPER_LIMIT.to_s}, but instead is #{sum}")
    end
  end

  def self.validate_global_constraint__total_char_delete_count(operations: operations)
    count = self.total_char_delete_count(operations: operations)
    if count > TOTAL_CHAR_DELETE_COUNT then
      Helper.raise__global_constraint__error(error: "The total char delete count (for operation type #{TYPE_DELETE}) must be <= #{TOTAL_CHAR_DELETE_COUNT}, but instead is #{count}")
    end
  end

  def self.sum_length_appendages(operations:)
    (operations.select{|op| Operation.append?(operation: op)})
      .map{|op| op.arg.length}
        .sum
  end

  def self.total_char_delete_count(operations:)
    (operations.select{|op| Operation.delete?(operation: op)})
      .map{|op| op.arg}
        .sum
  end

end

