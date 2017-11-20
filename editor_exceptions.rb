module EditorExceptions

  class AbstractEditorError < StandardError
  end

  class AbstractLineError < AbstractEditorError

    attr_accessor :line_number, :problem_description

    def initialize(line_number:, problem_description:)
      self.line_number = line_number
      self.problem_description = problem_description
    end

    def message
      "#{self.error_description} error on line# #{self.line_number.to_s}: #{self.problem_description}"
    end

    def error_description
      raise NotImplementedError
    end

  end

  class FormatError < AbstractLineError
    # Scope is current line
    # E.g., float instead of integer for operation count, or expecting all lowercase for appendage
    def error_description
      "Format"
    end
  end

  class SequenceError < AbstractLineError
    # Scope is entire input, with error manifesting on current line
    # E.g., string was appended on a prior line, and now attempting to delete char past end of string
    def error_description
      "Sequence"
    end
  end

end