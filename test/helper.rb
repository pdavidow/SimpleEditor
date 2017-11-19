module Helper

  def withCapturedStdout
    # https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string

    oldStdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = oldStdout
  end

end