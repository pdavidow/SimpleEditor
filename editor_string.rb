class EditorString

  def self.append(base_string:, appendage_string:)
    raise TypeError.new("base_string must be a string") unless (base_string.kind_of? String)
    raise TypeError.new("appendage_string must be a string") unless (appendage_string.kind_of? String)

    base_string ++ appendage_string
  end

  def self.delete_last_chars(string:, chars_to_delete_count:)
    raise TypeError.new("String must be a string") unless (string.kind_of? String)
    raise TypeError.new("Count must be an integer") unless (chars_to_delete_count.kind_of? Integer)

    raise ArgumentError.new("String may not be empty") unless (string.length >= 1)
    raise ArgumentError.new("1 >= count <= string length") unless ((chars_to_delete_count >= 1) && (chars_to_delete_count <= string.length))

    keep_count = string.length - chars_to_delete_count
    string.slice(0, keep_count)
  end

  def self.char_at_position(string:, position:)
    raise TypeError.new("String must be a string") unless (string.kind_of? String)
    raise TypeError.new("Position must be an integer") unless (position.kind_of? Integer)

    raise ArgumentError.new("String may not be empty") unless (string.length >= 1)
    raise ArgumentError.new("1 >= position <= string length") unless ((position >= 1) && (position <= string.length))

    string[position - 1]
  end
end