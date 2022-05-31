
# Tor executable is missing error
class TorUnavailable < StandardError
  def initialize
    super "Tor executable is unavailable in your path. \n" + \
      "Consider modifying your PATH environment variable"
  end
end

class FailedToSpawnTor < StandardError
  def initialize msg
    super "😔 #{msg}"
  end
end
