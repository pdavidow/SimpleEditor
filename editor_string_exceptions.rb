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
end