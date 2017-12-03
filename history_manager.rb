require_relative 'constants'

class HistoryManager

  def self.initial_history
    self.add_string_state(history: [], string_state: INITIAL_STATE)
  end

  def self.initial_history?(history:)
    history.length == 1
  end

  def self.current_state(history:)
    history.last
  end

  def self.current_string_state(history:)
    (self.current_state(history: history))
      .to_s
  end

  def self.add_string_state(history:, string_state:)
    symbol = string_state.to_sym
    self.add_state(history: history, state: symbol)
  end

  def self.add_state(history:, state:)
    history_clone = history.clone
    history_clone.push(state)

    history_clone
  end

  def self.remove_current_state(history:)
    history_clone = history.clone
    history_clone.pop

    history_clone
  end

end