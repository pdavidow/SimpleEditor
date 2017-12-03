require_relative 'constants'

class Operation

  attr_accessor :type_code, :arg, :proc

  def self.append?(operation:)
    operation.type_code == TYPE_APPEND
  end

  def self.delete?(operation:)
    operation.type_code == TYPE_DELETE
  end

  def self.print?(operation:)
    operation.type_code == TYPE_PRINT
  end

  def self.undo?(operation:)
    operation.type_code == TYPE_UNDO
  end

  #########################################################################################

  private def proc_for(type_code:, arg:)
    case type_code
      when TYPE_APPEND then Proc.new{|history| Editor.append(appendage_string: arg, history: history)}
      when TYPE_DELETE then Proc.new{|history| Editor.delete_last_chars(chars_to_delete_count: arg, history: history)}
      when TYPE_PRINT then Proc.new{|history| Editor.print_with_newline__char_at(position: arg, history: history)}
      when TYPE_UNDO then Proc.new{|history| Editor.undo(history: history)}
      else
    end
  end

  private def initialize(type_code:, arg:)
    self.type_code = type_code
    self.arg = arg
    self.proc = proc_for(type_code: self.type_code, arg: self.arg)
  end

end