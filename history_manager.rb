class HistoryManager

  def self.history
    @history ||= []
  end

  def self.resetHistory
    @history = nil
  end

  def self.currentState(history:)
    history.last.clone
  end

  def self.undo(history:)
    historyClone = history.clone
    historyClone.pop

    return historyClone
  end

end