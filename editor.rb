require_relative 'model'
require_relative 'history_manager'
require_relative 'editor_string'
require_relative 'constants'

class Editor

  def self.initial_string
    INITIAL_STATE
  end

  def self.perform_operation(operation:, model:, is_store_undo: true)
    case operation.type_code
      when TYPE_APPEND then self.append(appendage_string: operation.arg, operation: operation, model: model, is_store_undo: is_store_undo)
      when TYPE_DELETE then self.delete_last_chars(chars_to_delete_count: operation.arg, operation: operation, model: model, is_store_undo: is_store_undo)
      when TYPE_PRINT then self.print_with_newline__char_at(position: operation.arg, model: model)
      when TYPE_UNDO then self.undo(model: model)
      else
    end
  end

  def self.append(appendage_string:, operation:, model:, is_store_undo:) # todo make private...
    string = EditorString.append(base_string: model.string, appendage_string: appendage_string)

    history = if is_store_undo # todo refactor
      then
        undo_operation = Operation.undo_operation_for(operation: operation, string: model.string)
        HistoryManager.add_state(history: model.history, state: undo_operation)
      else
        model.history
      end

    Model.new(string: string, history: history)
  end

  def self.delete_last_chars(chars_to_delete_count:, operation:, model: model, is_store_undo:) # todo make private...
    string = EditorString.delete_last_chars(string: model.string, chars_to_delete_count: chars_to_delete_count)

    history = if is_store_undo # todo refactor
      then
        undo_operation = Operation.undo_operation_for(operation: operation, string: model.string)
        HistoryManager.add_state(history: model.history, state: undo_operation)
      else
        model.history
      end

    Model.new(string: string, history: history)
  end

  def self.print_with_newline__char_at(position:, model:)
    string = self.char_at_position(position: position, string: model.string)
    puts(string)

    model
  end

  def self.undo(model:)
    return model if HistoryManager.initial_history?(history: model.history)

    operation = HistoryManager.current_state(history: model.history)
    new_model = self.perform_operation(operation: operation, model: model, is_store_undo: false)
    history = HistoryManager.remove_current_state(history: model.history)

    Model.new(string: new_model.string, history: history)
  end

  def self.char_at_position(position:, string:)
    EditorString.char_at_position(string: string, position: position)
  end

  def self.stateful_message_for(message:, model:)
    message + ". Current string is '#{model.string}'"
  end

end