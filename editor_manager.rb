require_relative 'editor'
require_relative 'history_manager'

class EditorManager

  protected
  attr_accessor :history
  public

  def self.s(history:)
    HistoryManager.currentState(history: history)
  end

  def self.append(w:, history:)
    Editor.append(history: history, appendageString: w)
  end

  def self.delete(k:, history:)
    Editor.deleteLastChars(history: history, charsToDeleteCount: k)
  end

  def self.printCharAt(k:, s:) # with newline
    result = Editor.charAtPosition(string: s, position: k)
    puts(result)
  end

  def self.undo(history:)
    return history unless history.length > 1
    HistoryManager.removeCurrentState(history: history)
  end

  def initialize
    self.history = HistoryManager.addState(
        history: HistoryManager.new.history,
        state: Editor.initialState
    )
  end

  def s
    self.class.s(history: self.history)
  end

  def append(w:)
    self.history = self.class.append(w: w, history: self.history)
  end

  def delete(k:)
    self.history = self.class.delete(k: k, history: self.history)
  end

  def printCharAt(k:)
    self.class.printCharAt(k: k, s: self.s)
  end

  def undo
    self.history = self.class.undo(history: self.history)
  end

end