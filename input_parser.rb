require_relative 'helper'
require_relative 'constants'

class InputParser
  include Helper

  def self.parsed_operation_count(line_number:, string:)
    count = Helper.positive_integer_from(string: string)
    Helper.raise_format_error(line_number: line_number, error: 'Operation count must be a positive integer') if count.nil?
    Helper.raise_format_error(line_number: line_number, error: "Operation count must be a positive integer <= #{OPERATION_COUNT_UPPER_LIMIT.to_s}") if count > OPERATION_COUNT_UPPER_LIMIT
    count
  end

  def self.parsed_type_code(line_number:, string:)
    code = Helper.non_negative_integer_from(string: string)
    self.validated_type_code(line_number: line_number, code: code)
  end

  def self.parsed_arg(line_number:, string:, type_code:)
    case type_code
      when TYPE_APPEND then self.validated_appendage(line_number: line_number, string: string)
      when TYPE_DELETE then self.validated_char_count(line_number: line_number, string: string)
      when TYPE_PRINT then self.validated_char_position(line_number: line_number, string: string)
      else
    end
  end

  def self.validated_type_code(line_number:, code:)
    case code
      when
        TYPE_APPEND,
        TYPE_DELETE,
        TYPE_PRINT,
        TYPE_UNDO
          then code
      else Helper.raise_format_error(line_number: line_number, error: "Operation type must be #{TYPE_APPEND.to_s}, #{TYPE_DELETE.to_s}, #{TYPE_PRINT.to_s}, or #{TYPE_UNDO.to_s}")
    end
  end

  def self.validated_appendage(line_number:, string:)
    Helper.raise_format_error(line_number: line_number, error: "Appendage must be all lower case") unless (string.downcase == string)
    Helper.raise_format_error(line_number: line_number, error: "Appendage must be all English letters") if !Helper.is_alpha(string: string)
    string
  end

  def self.validated_char_count(line_number:, string:)
    int = Helper.positive_integer_from(string: string)
    Helper.raise_format_error(line_number: line_number, error: "Char count must be positive integer") if int.nil?
    int
  end

  def self.validated_char_position(line_number:, string:)
    int = Helper.positive_integer_from(string: string)
    Helper.raise_format_error(line_number: line_number, error: "Char position must be positive integer") if int.nil?
    int
  end

end