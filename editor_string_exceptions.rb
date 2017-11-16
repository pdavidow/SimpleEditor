module  EditorStringExceptions

  class EditorStringError < StandardError
  end

  class AppendError < EditorStringError
    def message
      "Invalid append"
    end
  end

  class LowerCaseError < AppendError
    def message
      "Appendage must be all lower case"
    end
  end

  class DeleteLastCharsError < EditorStringError
    def message
      "Invalid deleteLastChars"
    end
  end

  class CharCountOutOfBoundsError < DeleteLastCharsError
    def message
      "1 >= char count <= string length"
    end
  end

  class EmptyStringError < DeleteLastCharsError
    def message
      "String may not be empty"
    end
  end

end