class Operation

  DELIMETER = ' '

  attr_accessor :typeCode, :arg

  def initialize(line:)
    self.parseLine(line: line)
  end

  def parseLine(line: line)
    substrings = line.split(DELIMETER)

    self.parseTypeCode(substrings: substrings)
    self.parseArg(substrings: substrings)
  end

  def parseTypeCode(substrings: substrings)
    self.validateForPresenceOfTypeCode(substrings: substrings)

    code = Integer(substrings[0])
    self.typeCode = self.validatedTypeCode(code: code)
  end

  def validateForPresenceOfTypeCode(substrings: substrings)
    raise ArgumentError.new("Type-Code expected") if substrings.length == 0
  end

  def validatedTypeCode(code: code)
    case code
      when 1,2,3,4 then code
      else raise TypeError.new("Type must be 1, 2, 3, or 4")
    end
  end

  def parseArg(substrings: substrings)
    self.validateForPresenceOfArg(substrings: substrings)

    argString = substrings[1]
    self.arg =
      case (self.typeCode)
       when 1 then self.validatedAppendage(string: argString)
       when 2,3 then Integer(argString)
       else
     end
  end

  def validateForPresenceOfArg(substrings: substrings)
    if substrings.length == 1 then
      case self.typeCode
        when 1,2,3 then raise ArgumentError.new("Arg expected")
        else
      end
    end
  end

  def validatedAppendage(string: string)
    raise ArgumentError.new("Appendage must be all lower case") unless (string.downcase == string)
    raise ArgumentError.new("Appendage must be all English letters") if (string.match(/^[[:alpha:]]+$/).nil?) # https://stackoverflow.com/questions/10637606/doesnt-ruby-have-isalpha

    string
  end
end
