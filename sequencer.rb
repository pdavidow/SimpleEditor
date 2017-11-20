require_relative 'editor_manager'
require_relative 'reader'
require_relative 'helper'

class Sequencer
  include Helper

  ### input from file todo from STDIN
  ### output to STDOUT

  attr_accessor :inputFilename

  def self.sequence(editorManager:, operations:)
    operations.each {|op|
      begin
        op.opProc.call(editorManager)
      rescue Exception => exception
        Helper.raiseSequenceError(lineNumber: op.lineNumber, problemDescription: exception.message)
      end
    }
  end

  def initialize(inputFilename:)
    self.inputFilename = inputFilename
  end

  def editorManager
    @editorManager ||= EditorManager.new
  end

  def reader
    @reader ||= Reader.new(filename: self.inputFilename)
  end

  def operations
    self.reader.operations
  end

  def sequence
    self.class.sequence(editorManager: self.editorManager, operations: self.operations)
  end
end
