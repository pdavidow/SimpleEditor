module Helper

  def integerFrom(string: string)
    #see https://stackoverflow.com/questions/24980295/strictly-convert-string-to-integer-or-nil
    string.to_i if string[/^-?\d+$/]
  end

  def nonNegativeIntegerFrom(string: string)
    result = integerFrom(string: string)
    return nil if result.nil?
    return nil if result < 0
    result
  end

end