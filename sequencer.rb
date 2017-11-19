require_relative 'editor_manager'
require_relative 'reader'

class Sequencer

  ### input from file
  ### output to STDOUT

  attr_accessor :inputFilename

  def initialize(inputFilename: inputFilename)
    self.inputFilename = inputFilename
  end

  def editorManager
    @editorManager ||= EditorManager.new()
  end

  def reader
    @reader ||= Reader.new(filename: self.inputFilename)
  end

  def operations
    self.reader.operations
  end

  def sequence
    self.operations.each {|op| op.opProc.call(self.editorManager)}
  end
end
