require_relative 'operation'
require_relative 'input_line'
require_relative 'helper'

class Reader
  ## todo ########################################## WRONG. Dont overdesign. Just first read first lines, and then only those # lines


  ####### todo ############ https://stackoverflow.com/questions/25168662/how-to-read-lines-from-file-into-array
  #Be VERY careful reading a file into memory all at once.
      #It's not scalable, and can easily make a program crawl if the file turns out to be bigger than the available memory. Line-by-line is as fast and is the way to go if at all possible.

  include Helper

  OPERATION_COUNT_LINE_NUMBER = 1

  def initialize()
    self.validate
  end

  def operations
    @operations ||= self.operation_lines.map {|line| Operation.new(input_line: line)}
  end

  def lines
    @lines ||= self.get_lines
  end

  def operation_count
    @operation_count ||= self.get_operation_count
  end

  def operation_lines
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
    Helper.raise_format_error(line_number: OPERATION_COUNT_LINE_NUMBER, problem: "Number of actual operations is wrong") unless (self.operation_lines.length == self.operation_count)
  end

  def get_lines
    raw_lines = STDIN.readlines # todo UHOH
    raw_lines.map.with_index {|line, index| InputLine.new(string: line, number: index + 1)}
  end

  def get_operation_count
    string = self.operation_count_line.string
    count = Helper.non_negative_integer_from(string: string)
    Helper.raise_format_error(line_number: OPERATION_COUNT_LINE_NUMBER, problem: "Operation count expected, and must be a non_negative integer. Nothing else on the line expected.") if count.nil?
    count
  end

  def get_operation_lines
    clone = self.lines.clone
    clone.delete_at(self.operation_count_line_index)
    clone
  end
end

