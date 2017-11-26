require_relative 'history_manager'
require_relative 'editor_string'

class Editor

  def self.state(history:)
    HistoryManager.current_state(history: history)
  end

  def self.append(appendage_string:, history:)
    current_state = HistoryManager.current_state(history: history)
    result = EditorString.append(base_string: current_state, appendage_string: appendage_string)
    history_clone = HistoryManager.add_state(history: history, state: result)

    history_clone
  end

  def self.delete_last_chars(chars_to_delete_count:, history:)
    current_state = HistoryManager.current_state(history: history)
    result = EditorString.delete_last_chars(string: current_state, chars_to_delete_count: chars_to_delete_count)
    history_clone = HistoryManager.add_state(history: history, state: result)

    history_clone
  end

  def self.char_at_position(position:, history:)
    current_state = HistoryManager.current_state(history: history)
    EditorString.char_at_position(string: current_state, position: position)
  end

  def self.print_with_newline__char_at(position:, history:)
    result = self.char_at_position(position: position, history: history)
    puts(result)
    history
  end

  def self.undo(history:)
    return history if HistoryManager.initial_history?(history: history)
    HistoryManager.remove_current_state(history: history)
  end

  def self.statefulMessageFor(message:, history:)
    state = self.state(history: history)
    message + ". Current string is '#{state.to_s}'"
  end

end