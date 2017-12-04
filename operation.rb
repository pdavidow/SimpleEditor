class Operation

  attr_accessor :type_code

  def self.undo_operation_for(operation:, string: nil)
    case operation.type_code
      when TYPE_APPEND then self.new(type_code: TYPE_DELETE, arg: operation.arg.length)
      when TYPE_DELETE then
        count = operation.arg
        appendage_string = string.slice(-count, count)
        self.new(type_code: TYPE_APPEND, arg: appendage_string)
      else self.new(type_code: TYPE_NIL)
    end

  end

  #########################################################################################

  def arg
    external_arg
  end

  private def initialize(type_code:, arg: nil)
    self.type_code = type_code
    @internal_arg = internal_arg(type_code: self.type_code, arg: arg)
  end

  private def internal_arg(type_code:, arg:)
    case type_code
      when TYPE_APPEND then arg#.to_sym todo
      else arg
    end
  end

  private def external_arg
    case type_code
      when TYPE_APPEND then @internal_arg#.to_s todo
      else @internal_arg
    end
  end

end