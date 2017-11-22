require_relative 'input_parser'
require_relative 'operation'
require_relative 'helper'

class InputLine
  include Helper

  DELIMETER = ' '

  def self.operation_count_from(line_number:, string:)
    substrings = string.split(DELIMETER)

    self.validate_for_presence_of_operation_count(line_number: line_number, substrings: substrings)
    InputParser.parsed_operation_count(line_number: line_number, string: substrings[0])
  end

  def self.operation_from(line_number:, string:)
    substrings = string.split(DELIMETER)

    self.validate_for_presence_of_type_code(line_number: line_number, substrings: substrings)
    type_code = InputParser.parsed_type_code(line_number: line_number, string: substrings[0])

    self.validate_for_presence_of_arg(line_number: line_number, substrings: substrings, type_code: type_code)
    arg = InputParser.parsed_arg(line_number: line_number, string: substrings[1], type_code: type_code)

    Operation.new(line_number: line_number, type_code: type_code, arg: arg)
  end

  def self.validate_for_presence_of_operation_count(line_number:, substrings:)
    Helper.raise_format_error(line_number: line_number, error: 'Operation count expected') if substrings.length == 0
    Helper.raise_format_error(line_number: line_number, error: 'Operation count expected, and nothing else') if substrings.length > 1
  end

  def self.validate_for_presence_of_type_code(line_number:, substrings:)
    Helper.raise_format_error(line_number: line_number, error: 'Operation type expected') if substrings.length == 0
  end

  def self.validate_for_presence_of_arg(line_number:, substrings:, type_code:)
    case type_code
      when 1,2,3 then Helper.raise_format_error(line_number: line_number, error: "Argument expected for operation type #{type_code.to_s}") if substrings.length == 1
      when 4 then Helper.raise_format_error(line_number: line_number, error: 'No argument expected for operation type 4') if substrings.length > 1
      else
    end
  end

end