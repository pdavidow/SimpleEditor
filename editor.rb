require_relative 'editor_string'

class Editor

  def self.initial_state
    ""
  end

  def self.append(history:, appendage_string:)
    current_state = HistoryManager.current_state(history: history)
    result = EditorString.append(base_string: current_state, appendage_string: appendage_string)
    history_clone = HistoryManager.add_state(history: history, state: result)

    history_clone
  end


  def self.delete_last_chars(history:, chars_to_delete_count:)
    current_state = HistoryManager.current_state(history: history)
    result = EditorString.delete_last_chars(string: current_state, chars_to_delete_count: chars_to_delete_count)
    history_clone = HistoryManager.add_state(history: history, state: result)

    history_clone
  end

  def self.char_at_position(string:, position:)
    EditorString.char_at_position(string: string, position: position)
  end
end