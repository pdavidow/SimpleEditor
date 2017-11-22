class Operation

  attr_accessor :line_number, :proc

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
    self.proc = self.class.proc_for(type_code: type_code, arg: arg)
  end

end