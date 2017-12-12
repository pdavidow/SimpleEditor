require_relative 'constants'

class Model

  attr_accessor :string, :undos, :appendage_length_sum, :char_delete_count_sum

  #########################################################################################

  private def initialize(string: INITIAL_STATE, undos: [], appendage_length_sum: 0, char_delete_count_sum: 0)
    self.string = string
    self.undos = undos
    self.appendage_length_sum = appendage_length_sum
    self.char_delete_count_sum = char_delete_count_sum
  end

end