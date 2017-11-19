require_relative 'operation'
require_relative 'helper'

class Reader
  include Helper

  OPERATION_COUNT_LINE_NUMBER = 1

  attr_accessor :filename

  def initialize(filename:)
    self.filename = filename
    self.validate()
  end

  def operations
    @operations ||= self.getOperations()
  end

  def lines
    @lines ||= self.getLines()
  end

  def operationCount
    @operationCount ||= self.getOperationCount()
  end

  def operationLines
    @operationLines ||= self.getOperationLines()
  end

  def getLines
    IO.readlines(self.filename)
  end

  def operationCountLineIndex
    OPERATION_COUNT_LINE_NUMBER - 1
  end

  def operationCountLine
    self.lines[self.operationCountLineIndex]
  end

  def getOperationCount
    string = self.operationCountLine()
    count = nonNegativeIntegerFrom(string: string)
    raise ArgumentError.new("Operation count must be a non-negative integer") if count.nil?
    count
  end

  def getOperationLines
    clone = self.lines.clone()
    clone.delete_at(self.operationCountLineIndex)
    clone
  end

  def getOperations
    self.operationLines.map {|line| Operation.new(line: line)}
  end

  def validate
    self.operationCount
    self.operations
    raise ScriptError.new("Number of actual operations is wrong") unless (self.operationLines.length == self.operationCount)
  end
end