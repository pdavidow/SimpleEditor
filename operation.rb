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

  def self.proc_for(type_code:, arg:)
    case type_code
      when 1 then Proc.new{|editor_mgr| editor_mgr.append(w: arg)}
      when 2 then Proc.new{|editor_mgr| editor_mgr.delete(k: arg)}
      when 3 then Proc.new{|editor_mgr| editor_mgr.print_char_at(k: arg)}
      when 4 then Proc.new{|editor_mgr| editor_mgr.undo}
      else
    end
  end

  def initialize(line_number:, type_code:, arg:)
    self.line_number = line_number
    self.type_code = type_code
    self.arg = arg
    self.proc = self.class.proc_for(type_code: type_code, arg: arg)
  end

end