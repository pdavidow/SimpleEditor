require_relative 'constants'

class HistoryManager

  def self.initial_history
    []
  end

  def self.initial_history?(history:)
    history.length == 0
  end

  def self.current_state(history:)
    history.last
  end

  def self.add_state(history:, state:)
    history + [state]
  end

  def self.remove_current_state(history:)
    history.slice(0, history.length - 1)
  end

end