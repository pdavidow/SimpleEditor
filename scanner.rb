require_relative 'editor'
require_relative 'parser'
require_relative 'helper'
require_relative 'editor_exceptions'

class Scanner
  include Helper
  include EditorExceptions

  def self.scan
    operation_count = read_operation_count
    model = Editor.initial_model

    (2..(operation_count + 1)).each do |line_number|
      begin
        operation = read_operation(line_number: line_number)
        model = Editor.perform_operation(operation: operation, model: model)
      rescue FormatError => exception
        exception.line_number = line_number if exception.line_number.nil?
        raise exception
      rescue GlobalConstraintError => exception
        exception.line_number = line_number if exception.line_number.nil?
        raise exception
      rescue StatefulError => exception
        error = Editor.stateful_message_for(message: exception.message, model: model)
        Helper.raise_sequence_error(line_number: line_number, error: error)
      rescue StandardError => exception
        Helper.raise_sequence_error(line_number: line_number, error: exception.message)
      end
    end
  end

  #########################################################################################

  private_class_method def self.read_operation_count
    line_number = 1

    begin
      string = $stdin.readline
      Parser.operation_count_from(line_number: line_number, string: string)
    rescue EOFError
      Helper.raise_format_error(line_number: line_number, error: 'Operation count expected')
    end
  end

  private_class_method def self.read_operation(line_number:)
    begin
      string = $stdin.readline
      Parser.operation_from(line_number: line_number, string: string)
    rescue EOFError
      Helper.raise_format_error(line_number: line_number, error: 'Operation expected')
    end
  end

end