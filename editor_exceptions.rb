module EditorExceptions

  class AbstractEditorError < StandardError
  end

  class AbstractLineError < AbstractEditorError

    attr_accessor :lineNumber, :problemDescription

    def initialize(lineNumber:, problemDescription:)
      self.lineNumber = lineNumber
      self.problemDescription = problemDescription
    end

    def message
      "#{self.errorDescription} error on line# #{self.lineNumber.to_s}: #{self.problemDescription}"
    end

    def errorDescription
      raise NotImplementedError
    end

  end

  class FormatError < AbstractLineError
    # Scope is current line
    # E.g., float instead of integer for operation count, or expecting all lowercase for appendage
    def errorDescription
      "Format"
    end
  end

  class SequenceError < AbstractLineError
    # Scope is entire input, with error manifesting on current line
    # E.g., string was appended on a prior line, and now attempting to delete char past end of string
    def errorDescription
      "Sequence"
    end
  end

end