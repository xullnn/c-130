class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def listen
    record(yield) if block_given? && yield
  end

  def play
    puts @recordings
  end
end

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play
