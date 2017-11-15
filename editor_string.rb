require_relative 'editor_string_exceptions'

class EditorString
  include EditorStringExceptions

  def self.append(baseString:, appendageString:)
    raise TypeError.new("baseString must be a String") unless (baseString.kind_of? String)
    raise TypeError.new("appendageString must be a String") unless (appendageString.kind_of? String)

    raise LowerCaseError.new unless (appendageString.downcase == appendageString)

    return (baseString ++ appendageString)
  end


  def self.deleteLastChars(string:, charsToDeleteCount:)
    raise TypeError.new("string must be a String") unless (string.kind_of? String)
    raise TypeError.new("charCount must be an Integer") unless (charsToDeleteCount.kind_of? Integer)

    raise EmptyStringError.new unless (string.length >= 1)
    raise CharCountOutOfBoundsError.new unless ((charsToDeleteCount >= 1) && (charsToDeleteCount <= string.length))

    keepCount = string.length - charsToDeleteCount
    return string.slice(0, keepCount)
  end

end