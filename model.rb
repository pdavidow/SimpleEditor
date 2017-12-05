class Model

  attr_accessor :history, :appendage_length_sum

  #########################################################################################

  private def initialize(history: HistoryManager.initial_history, appendage_length_sum: 0)
    self.history = history
    self.appendage_length_sum = appendage_length_sum
  end

end

