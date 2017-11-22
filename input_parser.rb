require_relative 'helper'

class InputParser
  include Helper

  DELIMETER = ' '

  def self.parsed_operation_count(line_number:, string:)
    count = Helper.non_negative_integer_from(string: string)
    Helper.raise_format_error(line_number: line_number, error: "Operation count must be a non_negative integer") if count.nil?
    count
  end

  def self.parsed_type_code(line_number:, string:)
    code = Helper.non_negative_integer_from(string: string)
    self.validated_type_code(line_number: line_number, code: code)
  end

  def self.parsed_arg(line_number:, string:, type_code:)
    case type_code
      when 1 then self.validated_appendage(line_number: line_number, string: string)
      when 2 then self.validated_char_count(line_number: line_number, string: string)
      when 3 then self.validated_char_position(line_number: line_number, string: string)
      else
    end
  end

  def self.validated_type_code(line_number:, code:)
    case code
      when 1,2,3,4 then code
      else Helper.raise_format_error(line_number: line_number, error: "Operation type must be 1, 2, 3, or 4")
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