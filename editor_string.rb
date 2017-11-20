class EditorString

  def self.append(baseString:, appendageString:)
    raise TypeError.new("baseString must be a String") unless (baseString.kind_of? String)
    raise TypeError.new("appendageString must be a String") unless (appendageString.kind_of? String)

    baseString ++ appendageString
  end

  def self.deleteLastChars(string:, charsToDeleteCount:)
    raise TypeError.new("string must be a String") unless (string.kind_of? String)
    raise TypeError.new("charsToDeleteCount must be an Integer") unless (charsToDeleteCount.kind_of? Integer)

    raise ArgumentError.new("String may not be empty") unless (string.length >= 1)
    raise ArgumentError.new("1 >= count <= string length") unless ((charsToDeleteCount >= 1) && (charsToDeleteCount <= string.length))

    keepCount = string.length - charsToDeleteCount
    string.slice(0, keepCount)
  end

  def self.charAtPosition(string:, position:)
    raise TypeError.new("string must be a String") unless (string.kind_of? String)
    raise TypeError.new("position must be an Integer") unless (position.kind_of? Integer)

    raise ArgumentError.new("String may not be empty") unless (string.length >= 1)
    raise ArgumentError.new("1 >= position <= string length") unless ((position >= 1) && (position <= string.length))

    string[position - 1]
  end
end