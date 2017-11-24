require_relative 'editor'
require_relative 'history_manager'

class EditorManager

  protected
  attr_accessor :history
  public

  def self.state(history:)
    HistoryManager.current_state(history: history)
  end

  def self.append(appendage_string:, history:)
    Editor.append(history: history, appendage_string: appendage_string)
  end

  def self.delete(chars_to_delete_count:, history:)
    Editor.delete_last_chars(history: history, chars_to_delete_count: chars_to_delete_count)
  end

  def self.print_char_at(position:, state:) # with newline
    result = Editor.char_at_position(string: state, position: position)
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

  def state
    self.class.state(history: self.history)
  end

  def append(appendage_string:)
    self.history = self.class.append(appendage_string: appendage_string, history: self.history)
  end

  def delete(chars_to_delete_count:)
    self.history = self.class.delete(chars_to_delete_count: chars_to_delete_count, history: self.history)
  end

  def print_char_at(position:)
    self.class.print_char_at(position: position, state: self.state)
  end

  def undo
    self.history = self.class.undo(history: self.history)
  end

end