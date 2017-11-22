require_relative 'helper'

class Operation
  include Helper

  DELIMETER = ' '

  attr_accessor :input_line, :type_code, :arg

  def self.op_proc(type_code:, arg:)
    case type_code
      when 1 then Proc.new{|editor_mgr| editor_mgr.append(w: arg)}
      when 2 then Proc.new{|editor_mgr| editor_mgr.delete(k: arg)}
      when 3 then Proc.new{|editor_mgr| editor_mgr.print_char_at(k: arg)}
      when 4 then Proc.new{|editor_mgr| editor_mgr.undo}
      else
    end
  end

  def self.parsed_type_code(line_number:, substrings:)
    self.validate_for_presence_of_type_code(line_number: line_number, substrings: substrings)

    string = substrings[0]
    code = Helper.non_negative_integer_from(string: string)
    self.validated_type_code(line_number: line_number, code: code)
  end

  def self.parsed_arg(line_number:, substrings:, type_code:)
    self.validate_for_presence_of_arg(line_number: line_number, substrings: substrings, type_code: type_code)

    arg_string = substrings[1]
    case type_code
      when 1 then self.validated_appendage(line_number: line_number, string: arg_string)
      when 2 then self.validated_char_count(line_number: line_number, string: arg_string)
      when 3 then self.validated_char_position(line_number: line_number, string: arg_string)
      else
    end
  end

  def self.validate_for_presence_of_type_code(line_number:, substrings:)
    Helper.raise_format_error(line_number: line_number, problem: "Operation type expected") if substrings.length == 0
  end

  def self.validated_type_code(line_number:, code:)
    case code
      when 1,2,3,4 then code
      else Helper.raise_format_error(line_number: line_number, problem: "Operation type must be 1, 2, 3, or 4")
    end
  end

  def self.validate_for_presence_of_arg(line_number:, substrings:, type_code:)
    case type_code
      when 1,2,3 then Helper.raise_format_error(line_number: line_number, problem: "Argument expected for operation type #{type_code.to_s}") if substrings.length == 1
      when 4 then Helper.raise_format_error(line_number: line_number, problem: "No argument expected for operation type 4") if substrings.length > 1
      else
    end
  end

  def self.validated_appendage(line_number:, string:)
    Helper.raise_format_error(line_number: line_number, problem: "Appendage must be all lower case") unless (string.downcase == string)
    Helper.raise_format_error(line_number: line_number, problem: "Appendage must be all English letters") if !Helper.is_alpha(string: string)
    string
  end

  def self.validated_char_count(line_number:, string:)
    int = Helper.positive_integer_from(string: string)
    Helper.raise_format_error(line_number: line_number, problem: "Char count must be positive integer") if int.nil?
    int
  end

  def self.validated_char_position(line_number:, string:)
    int = Helper.positive_integer_from(string: string)
    Helper.raise_format_error(line_number: line_number, problem: "Char position must be positive integer") if int.nil?
    int
  end

  def initialize(input_line:)
    self.input_line = input_line
    self.parse_line(line: self.input_line)
  end

  def op_proc
    @op_proc ||= self.class.op_proc(type_code: self.type_code, arg: self.arg)
  end

  def line_number
    self.input_line.number
  end

  def parse_line(line:)
    line_number = self.line_number
    substrings = line.string.split(DELIMETER)

    self.type_code = self.class.parsed_type_code(line_number: line_number, substrings: substrings)
    self.arg = self.class.parsed_arg(line_number: line_number, substrings: substrings, type_code: self.type_code)
  end

end
