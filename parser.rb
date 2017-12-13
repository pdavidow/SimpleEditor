require_relative 'helper'
require_relative 'constants'

class Parser
  include Helper

  def self.operation_count_from(line_number:, string:)
    substrings = string.split(OPERATION_DELIMETER)

    validate_for_presence_of_operation_count(line_number: line_number, substrings: substrings)
    parsed_operation_count(line_number: line_number, string: substrings[0])
  end

  def self.operation_from(line_number:, string:)
    substrings = string.split(OPERATION_DELIMETER)

    validate_for_presence_of_type_code(line_number: line_number, substrings: substrings)
    type_code = parsed_type_code(line_number: line_number, string: substrings[0])

    validate_for_presence_of_arg(line_number: line_number, substrings: substrings, type_code: type_code)
    arg = parsed_arg(line_number: line_number, string: substrings[1], type_code: type_code)

    {type_code: type_code, arg: arg}
  end

  #########################################################################################

  private_class_method def self.parsed_operation_count(line_number:, string:)
    count = Helper.positive_integer_from(string: string)
    Helper.raise_format_error(line_number: line_number, error: 'Operation count must be a positive integer') if count.nil?
    Helper.raise__global_constraint__error(line_number: line_number, error: "Operation count must be a positive integer <= #{OPERATION_COUNT__UPPER_LIMIT.to_s}") if count > OPERATION_COUNT__UPPER_LIMIT
    count
  end

  private_class_method def self.parsed_type_code(line_number:, string:)
    code = Helper.non_negative_integer_from(string: string)
    validated_type_code(line_number: line_number, code: code)
  end

  private_class_method def self.parsed_arg(line_number:, string:, type_code:)
    case type_code
      when TYPE_APPEND then validated_appendage(line_number: line_number, string: string)
      when TYPE_DELETE then validated_char_count(line_number: line_number, string: string)
      when TYPE_PRINT then validated_char_position(line_number: line_number, string: string)
      else
    end
  end

  private_class_method def self.validated_type_code(line_number:, code:)
    case code
      when
      TYPE_APPEND,
          TYPE_DELETE,
          TYPE_PRINT,
          TYPE_UNDO
      then code
      else
        Helper.raise_format_error(line_number: line_number, error: "Operation type must be #{TYPE_APPEND.to_s}, #{TYPE_DELETE.to_s}, #{TYPE_PRINT.to_s}, or #{TYPE_UNDO.to_s}")
    end
  end

  private_class_method def self.validated_appendage(line_number:, string:)
    Helper.raise_format_error(line_number: line_number, error: 'Appendage must be all lower case') unless (string.downcase == string)
    Helper.raise_format_error(line_number: line_number, error: 'Appendage must be all English letters') if !Helper.is_alpha(string: string)
    string
  end

  private_class_method def self.validated_char_count(line_number:, string:)
    int = Helper.positive_integer_from(string: string)
    Helper.raise_format_error(line_number: line_number, error: 'Char count must be positive integer') if int.nil?
    int
  end

  private_class_method def self.validated_char_position(line_number:, string:)
    int = Helper.positive_integer_from(string: string)
    Helper.raise_format_error(line_number: line_number, error: 'Char position must be positive integer') if int.nil?
    int
  end

  private_class_method def self.validate_for_presence_of_operation_count(line_number:, substrings:)
    Helper.raise_format_error(line_number: line_number, error: 'Operation count expected') if substrings.length == 0
    Helper.raise_format_error(line_number: line_number, error: 'Operation count expected, and nothing else') if substrings.length > 1
  end

  private_class_method def self.validate_for_presence_of_type_code(line_number:, substrings:)
    Helper.raise_format_error(line_number: line_number, error: 'Operation type expected') if substrings.length == 0
  end

  private_class_method def self.validate_for_presence_of_arg(line_number:, substrings:, type_code:)
    case type_code
      when
        TYPE_APPEND,
        TYPE_DELETE,
        TYPE_PRINT
          then Helper.raise_format_error(line_number: line_number, error: "Argument expected for operation type #{type_code.to_s}") if substrings.length == 1
      when
        TYPE_UNDO then Helper.raise_format_error(line_number: line_number, error: "No argument expected for operation type #{TYPE_UNDO.to_s}") if substrings.length > 1
      else
    end
  end

end