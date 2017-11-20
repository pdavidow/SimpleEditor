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
    @operations ||= self.operationLines.map {|line| Operation.new(inputLine: line)}
  end

  def lines
    def getLines
      rawLines = IO.readlines(self.filename)
      rawLines.map.with_index {|line, index| InputLine.new(string: line, number: index + 1)}
    end

    @lines ||= self.getLines
  end

  def operationCount
    def getOperationCount
      string = self.operationCountLine.string
      count = Helper.nonNegativeIntegerFrom(string: string)
      Helper.raiseFormatError(lineNumber: OPERATION_COUNT_LINE_NUMBER, problemDescription: "Operation count must be a non-negative integer") if count.nil?
      count
    end

    @operationCount ||= self.getOperationCount
  end

  def operationLines
    def getOperationLines
      clone = self.lines.clone
      clone.delete_at(self.operationCountLineIndex)
      clone
    end

    @operationLines ||= self.getOperationLines
  end

  def operationCountLineIndex
    OPERATION_COUNT_LINE_NUMBER - 1
  end

  def operationCountLine
    self.lines[self.operationCountLineIndex]
  end

  def validate
    self.operationCount
    self.operations
    Helper.raiseFormatError(lineNumber: OPERATION_COUNT_LINE_NUMBER, problemDescription: "Number of actual operations is wrong") unless (self.operationLines.length == self.operationCount)
  end
end