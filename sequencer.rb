require_relative 'editor'
require_relative 'reader'
require_relative 'helper'
require_relative 'editor_exceptions'

class Sequencer
  include Helper
  include EditorExceptions

  def self.sequence
    operation_count = Reader.read_operation_count
    history = HistoryManager.initial_history

    (2..(operation_count + 1)).each {|line_number|
      begin
        operation = Reader.read_operation(line_number: line_number)
        history = operation.proc.call(history)
      rescue FormatError => exception
        raise exception
      rescue GlobalConstraintError => exception
        raise exception
      rescue StatefulError => exception
        error = Editor.statefulMessageFor(message: exception.message, history: history)
        Helper.raise_sequence_error(line_number: line_number, error: error)
      rescue StandardError => exception
        Helper.raise_sequence_error(line_number: line_number, error: exception.message)
      end
    }
  end

end