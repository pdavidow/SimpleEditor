require_relative 'operation'
require_relative 'input_line'
require_relative 'helper'

class Reader
  include Helper

  OPERATION_COUNT_LINE_NUMBER = 1

  attr_accessor :filename

  def initialize(filename:)
    self.filename = filename
    self.validate
  end

  def operations
    @operations ||= self.operation_lines.map {|line| Operation.new(input_line: line)}
  end

  def lines
    def get_lines
      raw_lines = IO.readlines(self.filename)
      raw_lines.map.with_index {|line, index| InputLine.new(string: line, number: index + 1)}
    end

    @lines ||= self.get_lines
  end

  def operation_count
    def get_operation_count
      string = self.operation_count_line.string
      count = Helper.non_negative_integer_from(string: string)
      Helper.raise_format_error(line_number: OPERATION_COUNT_LINE_NUMBER, problem_description: "Operation count expected, and must be a non_negative integer. Nothing else on the line expected.") if count.nil?
      count
    end

    @operation_count ||= self.get_operation_count
  end

  def operation_lines
    def get_operation_lines
      clone = self.lines.clone
      clone.delete_at(self.operation_count_line_index)
      clone
    end

    @operation_lines ||= self.get_operation_lines
  end

  def operation_count_line_index
    OPERATION_COUNT_LINE_NUMBER - 1
  end

  def operation_count_line
    self.lines[self.operation_count_line_index]
  end

  def validate
    self.operation_count
    self.operations
    Helper.raise_format_error(line_number: OPERATION_COUNT_LINE_NUMBER, problem_description: "Number of actual operations is wrong") unless (self.operation_lines.length == self.operation_count)
  end
end

