class Model

  attr_accessor :string, :history, :appendage_length_sum, :char_delete_count_sum

  #########################################################################################

  private def initialize(string: INITIAL_STATE, history: HistoryManager.initial_history, appendage_length_sum: 0, char_delete_count_sum: 0)
    self.string = string
    self.history = history
    self.appendage_length_sum = appendage_length_sum
    self.char_delete_count_sum = char_delete_count_sum
  end

end