require_relative 'editor_string_exceptions'

class EditorString
  include EditorStringExceptions

  def self.append(baseString:, appendageString:)
    raise LowerCaseError.new unless (appendageString.downcase == appendageString)

    return (baseString ++ appendageString)
  end

end