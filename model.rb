class Model

  attr_accessor :string, :history

  #########################################################################################

  private def initialize(string: Editor.initial_string, history: HistoryManager.initial_history)
    self.string = string
    self.history = history
  end

end