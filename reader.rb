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

end



