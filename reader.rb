require_relative 'input_line'

class Reader

  def self.read
    count = self.read_operation_count
    self.read_operations(operation_count: count)
  end

  def self.read_operation_count
    line_number = 1
    InputLine.operation_count_from(line_number: line_number, string: STDIN.readline)
  end

  def self.read_operations(operation_count:)
    (2..(operation_count+1)).map {|line_number|
      InputLine.operation_from(line_number: line_number, string: STDIN.readline)
    }
  end

end

