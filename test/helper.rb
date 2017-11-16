module Helper

  def with_captured_stdout
    # https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string

    old_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end

end