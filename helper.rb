require_relative 'editor_exceptions'

module Helper
  include EditorExceptions

  def self.integerFrom(string: string)
    #see https://stackoverflow.com/questions/24980295/strictly-convert-string-to-integer-or-nil
    string.to_i if string[/^-?\d+$/]
  end

  def self.nonNegativeIntegerFrom(string: string)
    proc = Proc.new{|int| int < 0}
    self.scopedIntegerFrom(string: string, outOfScope: proc)
  end

  def self.positiveIntegerFrom(string: string)
    proc = Proc.new{|int| int < 1}
    self.scopedIntegerFrom(string: string, outOfScope: proc)
  end

  def self.scopedIntegerFrom(string: string, outOfScope: proc)
    result = integerFrom(string: string)

    return nil if result.nil?
    return nil if outOfScope.call(result)
    result
  end

  def self.isAlpha(string: string)
    # https://stackoverflow.com/questions/10637606/doesnt-ruby-have-isalpha
     !string.match(/^[[:alpha:]]+$/).nil?
  end

  def self.raiseFormatError(lineNumber:, problemDescription:)
    raise FormatError.new(lineNumber: lineNumber, problemDescription: problemDescription)
  end

  def self.raiseSequenceError(lineNumber:, problemDescription:)
    raise SequenceError.new(lineNumber: lineNumber, problemDescription: problemDescription)
  end

end