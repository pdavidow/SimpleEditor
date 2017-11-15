require_relative 'editor_string'

class Editor

  def self.initialState
    ""
  end

  def self.append(history:, appendageString:)
    currentState = HistoryManager.currentState(history: history)
    result = EditorString.append(baseString: currentState, appendageString: appendageString)

    historyClone = history.clone
    historyClone.push(result.clone)

    return historyClone
  end


  def self.deleteLastChars(history:, charsToDeleteCount:)
    currentState = HistoryManager.currentState(history: history)
    result = EditorString.deleteLastChars(string: currentState, charsToDeleteCount: charsToDeleteCount)

    historyClone = history.clone
    historyClone.push(result.clone)

    return historyClone
  end

end