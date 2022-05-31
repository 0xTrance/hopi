
# Tor executable is missing error
class FailedToSpawnTor < StandardError
  def initialize msg
    super "😔 #{msg}"
  end
end
