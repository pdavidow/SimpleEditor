require_relative 'editor_string'

class Editor

  def self.initialState
    ""
  end

  def self.append(history:, appendageString:)
    currentState = HistoryManager.currentState(history: history)
    result = EditorString.append(baseString: currentState, appendageString: appendageString)
    historyClone = HistoryManager.addState(history: history, state: result)

    historyClone
  end


  def self.deleteLastChars(history:, charsToDeleteCount:)
    currentState = HistoryManager.currentState(history: history)
    result = EditorString.deleteLastChars(string: currentState, charsToDeleteCount: charsToDeleteCount)
    historyClone = HistoryManager.addState(history: history, state: result)

    historyClone
  end

  def self.charAtPosition(string:, position:)
    EditorString.charAtPosition(string: string, position: position)
  end
end