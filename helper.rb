require_relative 'editor_exceptions'

module Helper
  include EditorExceptions

  def self.integer_from(string: string)
    #see https://stackoverflow.com/questions/24980295/strictly-convert-string-to-integer-or-nil
    string.to_i if string[/^_?\d+$/]
  end

  def self.non_negative_integer_from(string: string)
    proc = Proc.new{|int| int < 0}
    self.scoped_integer_from(string: string, out_of_scope: proc)
  end

  def self.positive_integer_from(string: string)
    proc = Proc.new{|int| int < 1}
    self.scoped_integer_from(string: string, out_of_scope: proc)
  end

  def self.scoped_integer_from(string: string, out_of_scope: proc)
    result = integer_from(string: string)

    return nil if result.nil?
    return nil if out_of_scope.call(result)
    result
  end

  def self.is_alpha(string: string)
    # https://stackoverflow.com/questions/10637606/doesnt-ruby-have-isalpha
     !string.match(/^[[:alpha:]]+$/).nil?
  end

  def self.raise_format_error(line_number:, problem:)
    raise FormatError.new(line_number: line_number, problem: problem)
  end

  def self.raise_sequence_error(line_number:, problem:)
    raise SequenceError.new(line_number: line_number, problem: problem)
  end

end
