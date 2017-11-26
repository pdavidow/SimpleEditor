module EditorExceptions

  class AbstractEditorError < StandardError
  end

  class StatefulError < AbstractEditorError
  end

  class CharArgumentError < StatefulError
  end

  class GlobalConstraintError < AbstractEditorError
  end

  class AbstractLineError < AbstractEditorError

    attr_accessor :line_number, :error

    def initialize(line_number:, error:)
      self.line_number = line_number
      self.error = error
    end

    def message
      "#{self.error_type} error on line# #{self.line_number.to_s}: #{self.error}"
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