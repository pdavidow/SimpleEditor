require_relative 'editor_manager'
require_relative 'reader'
require_relative 'helper'

class Sequencer
  include Helper

  ### input from file todo from STDIN
  ### output to STDOUT

  attr_accessor :input_filename

  def self.sequence(editor_manager:, operations:)
    operations.each {|op|
      begin
        op.op_proc.call(editor_manager)
      rescue Exception => exception
        Helper.raise_sequence_error(line_number: op.line_number, problem_description: exception.message)
      end
    }
  end

  def initialize(input_filename:)
    self.input_filename = input_filename
  end

  def editor_manager
    @editor_manager ||= EditorManager.new
  end

  def reader
    @reader ||= Reader.new(filename: self.input_filename)
  end

  def operations
    self.reader.operations
  end

  def sequence
    self.class.sequence(editor_manager: self.editor_manager, operations: self.operations)
  end
end
