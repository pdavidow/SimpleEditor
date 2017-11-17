class HistoryManager

  def history
    @history ||= []
  end

  def self.currentState(history:)
    history.last.clone
  end

  def self.addState(history:, state:)
    historyClone = history.clone
    historyClone.push(state.clone)

    historyClone
  end

  def self.removeCurrentState(history:)
    historyClone = history.clone
    historyClone.pop

    historyClone
  end

end