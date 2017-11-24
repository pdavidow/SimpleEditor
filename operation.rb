require_relative 'constants'

class Operation

  attr_accessor :line_number,:type_code, :arg, :proc

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
      when TYPE_APPEND then Proc.new{|editor_mgr| editor_mgr.append(appendage_string: arg)}
      when TYPE_DELETE then Proc.new{|editor_mgr| editor_mgr.delete(chars_to_delete_count: arg)}
      when TYPE_PRINT then Proc.new{|editor_mgr| editor_mgr.print_char_at(position: arg)}
      when TYPE_UNDO then Proc.new{|editor_mgr| editor_mgr.undo}
      else
    end
  end

  private def initialize(line_number:, type_code:, arg:)
    self.line_number = line_number
    self.type_code = type_code
    self.arg = arg
    self.proc = proc_for(type_code: type_code, arg: arg)
  end

end