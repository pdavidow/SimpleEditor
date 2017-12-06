class Operation

  attr_accessor :type_code, :arg

  #########################################################################################

  private def initialize(type_code:, arg: nil)
    self.type_code = type_code
    self.arg = arg
  end

end