module EditorExceptions

  class EditorError < StandardError
  end

  class ReaderError < EditorError

    def message_prefix
      "Error on line # : "
    end
  end

end