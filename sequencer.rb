require_relative 'model'
require_relative 'editor'
require_relative 'reader'
require_relative 'helper'
require_relative 'editor_exceptions'

class Sequencer
  include Helper
  include EditorExceptions

  def self.sequence
    operation_count = Reader.read_operation_count
    model = Model.new

    (2..(operation_count + 1)).each {|line_number|
      begin
        operation = Reader.read_operation(line_number: line_number)
        model = Editor.perform_operation(operation: operation, model: model)
      rescue FormatError => exception
        raise exception
      rescue StatefulError => exception
        error = Editor.stateful_message_for(message: exception.message, model: model)
        Helper.raise_sequence_error(line_number: line_number, error: error)
      rescue StandardError => exception
        Helper.raise_sequence_error(line_number: line_number, error: exception.message)
      end
    }
  end

end