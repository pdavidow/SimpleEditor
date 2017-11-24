require_relative 'editor_manager'
require_relative 'reader'
require_relative 'helper'
require_relative 'editor_exceptions'

class Sequencer
  include Helper
  include EditorExceptions

  def self.sequence(filename:)
    operations = Reader.read(filename: filename)
    editor_manager = EditorManager.new

    operations.each {|op|
      begin
        op.proc.call(editor_manager)
      rescue CharArgumentError => exception
        error = exception.message + ", for current string of '#{editor_manager.state.to_s}'"
        Helper.raise_sequence_error(line_number: op.line_number, error: error)
      rescue StandardError => exception
        Helper.raise_sequence_error(line_number: op.line_number, error: exception.message)
      end
    }
  end

end