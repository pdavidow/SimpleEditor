require_relative 'input_line'

class Reader

  def self.read(filename:)
    file = File.new(filename)
    count = self.read_operation_count(file: file)
    self.read_operations(file: file, operation_count: count)
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

end

