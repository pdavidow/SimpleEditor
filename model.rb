class Model

  attr_accessor :history, :appendage_length_sum, :char_delete_count_sum

  #########################################################################################

  private def initialize(history: HistoryManager.initial_history, appendage_length_sum: 0, char_delete_count_sum: 0)
    self.history = history
    self.appendage_length_sum = appendage_length_sum
    self.char_delete_count_sum = char_delete_count_sum
  end

end

