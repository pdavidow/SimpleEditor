class Reader

  OPERATION_COUNT_LINE_NUMBER = 1

  attr_accessor :filename

  def initialize(filename:)
    self.filename = filename
  end

  def lines
    @lines ||= getLines()
  end

  def operationCount
    @operationCount ||= getOperationCount()
  end

  def operations
    @operations ||= getOperations()
  end

  def operationLines
    @operationLines ||= getOperationLines()
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
    Integer(self.operationCountLine())
  end

  def getOperationLines
    copy = self.lines.copy()
    copy.delete_at(self.operationCountLineIndex)
    copy
  end

  def getOperations
    self.operationLines.map {|line| Operation.new(line: line)}
  end
end