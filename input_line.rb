class InputLine

  attr_accessor :string, :number

  def initialize(string: string, number: number = 0)
    self.string = string
    self.number = number
  end

end