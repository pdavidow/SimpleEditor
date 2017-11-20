require_relative 'editor'
require_relative 'history_manager'

class EditorManager

  protected
  attr_accessor :history
  public

  def self.s(history:)
    HistoryManager.current_state(history: history)
  end

  def self.append(w:, history:)
    Editor.append(history: history, appendage_string: w)
  end

  def self.delete(k:, history:)
    Editor.delete_last_chars(history: history, chars_to_delete_count: k)
  end

  def self.print_char_at(k:, s:) # with newline
    result = Editor.char_at_position(string: s, position: k)
    puts(result)
  end

  def self.undo(history:)
    return history unless history.length > 1
    HistoryManager.remove_current_state(history: history)
  end

  def initialize
    self.history = HistoryManager.add_state(
        history: HistoryManager.new.history,
        state: Editor.initial_state
    )
  end

  def s
    self.class.s(history: self.history)
  end

  def append(w:)
    self.history = self.class.append(w: w, history: self.history)
  end

  def delete(k:)
    self.history = self.class.delete(k: k, history: self.history)
  end

  def print_char_at(k:)
    self.class.print_char_at(k: k, s: self.s)
  end

  def undo
    self.history = self.class.undo(history: self.history)
  end

end