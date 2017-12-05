require_relative 'history_manager'
require_relative 'editor_string'

class Editor

  def self.string_state(model:)
    HistoryManager.current_string_state(history: model.history)
  end

  def self.perform_operation(operation:, model:)
    case operation.type_code
      when TYPE_APPEND then self.append(appendage_string: operation.arg, model: model)
      when TYPE_DELETE then self.delete_last_chars(chars_to_delete_count: operation.arg, model: model)
      when TYPE_PRINT then self.print_with_newline__char_at(position: operation.arg, model: model)
      when TYPE_UNDO then self.undo(model: model)
      else
    end
  end

# todo privatize...
  def self.append(appendage_string:, model:)
    sum = model.appendage_length_sum + appendage_string.length
    validate__appendage_length_sum(sum: sum)

    string_state = self.string_state(model: model)
    result = EditorString.append(base_string: string_state, appendage_string: appendage_string)
    history = HistoryManager.add_string_state(history: model.history, string_state: result)

    new_model = model.clone
    new_model.history = history
    new_model.appendage_length_sum = sum
    new_model
  end

  def self.delete_last_chars(chars_to_delete_count:, model:)
    string_state = self.string_state(model: model)
    result = EditorString.delete_last_chars(string: string_state, chars_to_delete_count: chars_to_delete_count)
    history = HistoryManager.add_string_state(history: model.history, string_state: result)

    new_model = model.clone
    new_model.history = history
    new_model
  end

  def self.print_with_newline__char_at(position:, model:)
    result = self.char_at_position(position: position, model: model)
    puts(result)
    model
  end

  def self.undo(model:)
    return model if HistoryManager.initial_history?(history: model.history)

    history = HistoryManager.remove_current_state(history: model.history)

    new_model = model.clone
    new_model.history = history
    new_model
  end

  def self.char_at_position(position:, model:)
    string_state = self.string_state(model: model)
    EditorString.char_at_position(string: string_state, position: position)
  end

  def self.stateful_message_for(message:, model:)
    string_state = self.string_state(model: model)
    message + ". Current string is '#{string_state}'"
  end

  private_class_method def self.validate__appendage_length_sum(sum:)
    if sum > APPENDAGE_LENGTH_SUM__UPPER_LIMIT then
      Helper.raise__global_constraint__error(error: "The sum of the lengths of all appendage arguments (for operation type #{TYPE_APPEND.to_s}) must be <= #{APPENDAGE_LENGTH_SUM__UPPER_LIMIT.to_s}, but instead is #{sum}")
    end
  end

end