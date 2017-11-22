require 'stringio'
# todo DELLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
module Helper

  def self.with_captured_stdout
    # https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string

    old_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end

  def self.redirect_stdin_to_file_then_process(filename:, proc:)
    begin
      file = STDIN.reopen(filename, "r")
      result = proc.call
    ensure
      file.close
    end
    result
  end

  def self.redirect_stdin_to_file_then_sequence(filename:)
    self.redirect_stdin_to_file_then_process(
        filename: filename,
        proc: Proc.new{self.with_captured_stdout {Sequencer.sequence}}
    )
  end



  ### hangs system, don't use ################################################# todo
  def self.redirect_stdin_to_string_then_process(string:, proc:)
    #old_stdin = $stdin
    $stdin = StringIO.new(string)
    result = proc.call
    #$stdin = old_stdin
    #result
  end

  def self.redirect_stdin_to_string_then_sequence(string:)
    self.redirect_stdin_to_string_then_process(
        string: string,
        proc: Proc.new{self.with_captured_stdout {Sequencer.sequence}}
    )
  end
  ##############################################################################

end
