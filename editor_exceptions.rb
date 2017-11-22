module EditorExceptions

  class AbstractEditorError < StandardError
  end

  class AbstractLineError < AbstractEditorError

    attr_accessor :line_number, :problem

    def initialize(line_number:, problem:)
      self.line_number = line_number
      self.problem = problem
    end

    def message
      "#{self.error_type} error on line# #{self.line_number.to_s}: #{self.problem}"
    end

    def error_type
      raise NotImplementedError
    end

  end

  class FormatError < AbstractLineError
    # Scope is current line
    # E.g., float instead of integer for operation count, or expecting all lowercase for appendage
    def error_type
      'Format'
    end
  end

  class SequenceError < AbstractLineError
    # Scope is entire input, with error manifesting on current line
    # E.g., string was appended on a prior line, and now attempting to delete char past end of string
    def error_type
      'Sequence'
    end
  end

end