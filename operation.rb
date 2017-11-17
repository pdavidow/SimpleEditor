class Operation

  DELIMETER = ' '

  attr_accessor :typeCode, :arg

  def initialize(line:)
    self.parseLine(line: line)
  end

  def parseLine(line: line)
    substrings = line.split(DELIMETER)

    self.parseTypeCode(string: substrings[0])

    if substrings.length == 1 then
      case self.typeCode
        when 1,2,3 then raise ArgumentError.new("Arg expected")
        else
      end
  end


    parseArg(string: substrings[1]) if (substrings.length == 2)
  end

  def parseTypeCode(string: string)
    code = Integer(string)
    self.typeCode = self.validatedTypeCode(code: code)
  end


  def validatedTypeCode(code: code)
    case code
      when 1,2,3,4 then code
      else raise TypeError.new("Type must be 1, 2, 3, or 4")
    end
  end

  def parseArg(string: string)
    self.arg =
      case (self.typeCode)
       when 1 then self.validatedAppendage(string: string)
       when 2,3 then Integer(string)
       else
     end
  end

  def validatedAppendage(string: string)
    raise ArgumentError.new("Appendage must be all lower case") unless (string.downcase == string)
    string
  end
end