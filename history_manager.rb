class HistoryManager

  def history
    @history ||= []
  end

  def self.current_state(history:)
    history.last.clone
  end

  def self.add_state(history:, state:)
    history_clone = history.clone
    history_clone.push(state.clone)

    history_clone
  end

  def self.remove_current_state(history:)
    history_clone = history.clone
    history_clone.pop

    history_clone
  end

end