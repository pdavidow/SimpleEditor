require_relative 'editor'
require_relative 'history_manager'

class EditorManager

  protected
  attr_accessor :history

  public

  def initialize
    self.history = HistoryManager.addState(
        history: HistoryManager.new.history,
        state: Editor.initialState
    )
  end

  def s
    HistoryManager.currentState(history: self.history)
  end

  def append(w:)
    self.history = Editor.append(
        history: self.history,
        appendageString: w
    )
  end

  def delete(k:)
    self.history = Editor.deleteLastChars(
        history: self.history,
        charsToDeleteCount: k)
  end

  def printCharAt(k:) # with newline
    string = self.s()
    result = Editor.charAtPosition(string: string, position: k)
    puts(result)
  end

  def undo
    return self.history unless self.history.length > 1

    self.history = HistoryManager.removeCurrentState(
        history: self.history
    )
  end

end