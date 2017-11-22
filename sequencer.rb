require_relative 'editor_manager'
require_relative 'reader'
require_relative 'helper'

class Sequencer
  include Helper

  def self.sequence(filename:)
    operations = Reader.read(filename: filename)
    editor_manager = EditorManager.new

    operations.each {|op|
      begin
        op.proc.call(editor_manager)
      rescue StandardError => exception
        Helper.raise_sequence_error(line_number: op.line_number, error: exception.message)
      end
    }
  end

end