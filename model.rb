class Model

  attr_accessor :history

  def initialize(string: Editor.initial_string, history: HistoryManager.initial_history)
    @symbol = string#.to_sym todo
    self.history = history
  end

  def string
    @symbol#.to_s todo
  end

end