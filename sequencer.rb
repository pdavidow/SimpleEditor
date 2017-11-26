require_relative 'editor'
require_relative 'reader'
require_relative 'helper'
require_relative 'editor_exceptions'

class Sequencer
  include Helper
  include EditorExceptions

  def self.sequence(filename:)
    operations = Reader.read(filename: filename)
    history = HistoryManager.initial_history

    operations.each {|op|
      begin
        history = op.proc.call(history)
      rescue StatefulError => exception
        error = Editor.statefulErrorFor(message: exception.message, history: history)
        Helper.raise_sequence_error(line_number: op.line_number, error: error)
      rescue StandardError => exception
        Helper.raise_sequence_error(line_number: op.line_number, error: exception.message)
      end
    }
  end

end