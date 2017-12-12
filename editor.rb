require_relative 'model'
require_relative 'constants'
require_relative 'editor_exceptions'

class Editor
  include EditorExceptions

  def self.perform_operation(operation:, model:)
    case operation.type_code
      when TYPE_APPEND then append(appendage_string: operation.arg, model: model)
      when TYPE_DELETE then delete_last_chars(chars_to_delete_count: operation.arg, model: model)
      when TYPE_PRINT then print_with_newline__char_at(position: operation.arg, model: model)
      when TYPE_UNDO then undo(model: model)
      when TYPE_UNDO_APPEND then basic_delete_last_chars(chars_to_delete_count: operation.arg, model: model)
      when TYPE_UNDO_DELETE then basic_append(appendage_string: operation.arg, model: model)
      else
    end
  end

  def self.stateful_message_for(message:, model:)
    message + ". Current string is '#{model.string}'"
  end

  #########################################################################################

  private_class_method def self.append(appendage_string:, model:)
    sum = model.appendage_length_sum + appendage_string.length
    validate__appendage_length_sum(sum: sum)

    chars_to_delete_count = appendage_string.length
    undo_operation = Operation.new(type_code: TYPE_UNDO_APPEND, arg: chars_to_delete_count)
    history = model.history + [undo_operation]

    new_model = basic_append(appendage_string: appendage_string, model: model)
    new_model.history = history
    new_model.appendage_length_sum = sum
    new_model
  end

  private_class_method def self.delete_last_chars(chars_to_delete_count:, model:)
    sum = model.char_delete_count_sum + chars_to_delete_count
    validate__char_delete_count_sum(sum: sum)

    appendage_string = model.string.slice(-chars_to_delete_count, chars_to_delete_count)
    undo_operation = Operation.new(type_code: TYPE_UNDO_DELETE, arg: appendage_string)
    history = model.history + [undo_operation]

    new_model = basic_delete_last_chars(chars_to_delete_count: chars_to_delete_count, model: model)
    new_model.history = history
    new_model.char_delete_count_sum  = sum
    new_model
  end

  private_class_method def self.print_with_newline__char_at(position:, model:)
    string = char_at_position(position: position, string: model.string)
    puts(string)

    model
  end

  private_class_method def self.undo(model:)
    return model if model.history.length == 0

    undo_operation = model.history.last

    new_model = self.perform_operation(operation: undo_operation, model: model)
    new_model.history = model.history.slice(0, model.history.length - 1)
    new_model
  end

  private_class_method def self.char_at_position(position:, string:)
    raise ArgumentError.new('String may not be empty') unless (string.length >= 1)
    raise CharArgumentError.new('1 <= position <= string length') unless ((position >= 1) && (position <= string.length))

    string[position - 1]
  end

  private_class_method def self.basic_append(appendage_string:, model:)
    string = model.string + appendage_string

    new_model = model.clone
    new_model.string = string
    new_model
  end

  private_class_method def self.basic_delete_last_chars(chars_to_delete_count:, model:)
    original = model.string

    raise ArgumentError.new('String may not be empty') unless (original.length >= 1)
    raise CharArgumentError.new('1 <= count <= string length') unless ((chars_to_delete_count >= 1) && (chars_to_delete_count <= original.length))

    keep_count = original.length - chars_to_delete_count
    string = original.slice(0, keep_count)

    new_model = model.clone
    new_model.string = string
    new_model
  end

  private_class_method def self.validate__appendage_length_sum(sum:)
    if sum > APPENDAGE_LENGTH_SUM__UPPER_LIMIT
      Helper.raise__global_constraint__error(error: "The sum of the lengths of all appendage arguments (for operation type #{TYPE_APPEND.to_s}) must be <= #{APPENDAGE_LENGTH_SUM__UPPER_LIMIT.to_s}, but instead is #{sum}")
    end
  end

  private_class_method def self.validate__char_delete_count_sum(sum:)
    if sum > CHAR_DELETE_COUNT_SUM__UPPER_LIMIT
      Helper.raise__global_constraint__error(error: "The total char delete count (for operation type #{TYPE_DELETE}) must be <= #{CHAR_DELETE_COUNT_SUM__UPPER_LIMIT}, but instead is #{sum}")
    end
  end

end