require_relative 'helper'

class Operation
  include Helper

  DELIMETER = ' '

  attr_accessor :inputLine, :typeCode, :arg

  def self.opProc(typeCode:, arg:)
    case typeCode
      when 1 then Proc.new{|editorMgr| editorMgr.append(w: arg)}
      when 2 then Proc.new{|editorMgr| editorMgr.delete(k: arg)}
      when 3 then Proc.new{|editorMgr| editorMgr.printCharAt(k: arg)}
      when 4 then Proc.new{|editorMgr| editorMgr.undo}
      else
    end
  end

  def self.parsedTypeCode(lineNumber:, substrings:)
    def self.validateForPresenceOfTypeCode(lineNumber:, substrings:)
      Helper.raiseFormatError(lineNumber: lineNumber, problemDescription: "Operation type expected") if substrings.length == 0
    end

    def self.validatedTypeCode(lineNumber:, code:)
      case code
        when 1,2,3,4 then code
        else Helper.raiseFormatError(lineNumber: lineNumber, problemDescription: "Operation type must be 1, 2, 3, or 4")
      end
    end

    self.validateForPresenceOfTypeCode(lineNumber: lineNumber, substrings: substrings)

    string = substrings[0]
    code = Helper.nonNegativeIntegerFrom(string: string)
    self.validatedTypeCode(lineNumber: lineNumber, code: code)
  end

  def self.parsedArg(lineNumber:, substrings:, typeCode:)
    def self.validateForPresenceOfArg(lineNumber:, substrings:, typeCode:)
      if substrings.length == 1 then
        case typeCode
          when 1,2,3 then Helper.raiseFormatError(lineNumber: lineNumber, problemDescription: "Argument expected for operation type #{typeCode.to_s}")
          else
        end
      end
    end

    def self.validatedAppendage(lineNumber:, string:)
      Helper.raiseFormatError(lineNumber: lineNumber, problemDescription: "Appendage must be all lower case") unless (string.downcase == string)
      Helper.raiseFormatError(lineNumber: lineNumber, problemDescription: "Appendage must be all English letters") if !Helper.isAlpha(string: string)
      string
    end

    def self.validatedCharCount(lineNumber:, string:)
      int = Helper.positiveIntegerFrom(string: string)
      Helper.raiseFormatError(lineNumber: lineNumber, problemDescription: "Char count must be positive integer") if int.nil?
      int
    end

    def self.validatedCharPosition(lineNumber:, string:)
      int = Helper.positiveIntegerFrom(string: string)
      Helper.raiseFormatError(lineNumber: lineNumber, problemDescription: "Char position must be positive integer") if int.nil?
      int
    end

    self.validateForPresenceOfArg(lineNumber: lineNumber, substrings: substrings, typeCode: typeCode)

    argString = substrings[1]
    case typeCode
      when 1 then self.validatedAppendage(lineNumber: lineNumber, string: argString)
      when 2 then self.validatedCharCount(lineNumber: lineNumber, string: argString)
      when 3 then self.validatedCharPosition(lineNumber: lineNumber, string: argString)
      else
    end
  end

  def initialize(inputLine:)
    self.inputLine = inputLine
    self.parseLine(line: self.inputLine)
  end

  def opProc
    @opProc ||= self.class.opProc(typeCode: self.typeCode, arg: self.arg)
  end

  def lineNumber
    self.inputLine.number
  end

  def parseLine(line:)
    lineNumber = self.lineNumber
    substrings = line.string.split(DELIMETER)

    self.typeCode = self.class.parsedTypeCode(lineNumber: lineNumber, substrings: substrings)
    self.arg = self.class.parsedArg(lineNumber: lineNumber, substrings: substrings, typeCode: self.typeCode)
  end

end
