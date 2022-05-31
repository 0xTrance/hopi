class TorClient

  include Process

  attr_reader :tor_pid, :tor_available, :tor_master

  def initialize torrc_path=nil
    @torrc_path = torrc_path
    @torr_log_output = []
  end

  def tor_available?
    find_executable 'tor'
  end

  def down
    @tor_master.close
    kill :QUIT, @tor_pid
    puts "🔻Killed Tor instance"
    true
  end

  def up
    raise FailedToSpawnTor "[err] Tor executable is unavailable. Consider modifying your PATH env" unless tor_available?

    master, slave = PTY.open
    read,write = IO.pipe

    if @torrc_path.nil?
      pid = spawn "tor", :in=>read, :out=>slave
    else
      pid = spawn "tor -f #{torrc_path}", :in=>read, :out=>slave
    end

    read.close
    slave.close
    write.close
      
    puts "🤞Waiting for tor to spawn ..."

    loop do
      line = master.gets
      raise FailedToSpawnTor.new "[err] Failed to spawn tor process" if line.nil?
      raise FailedToSpawnTor.new line if ["[warn]", "[err]"].any?{|loglevel| line.include? loglevel}
      if line.include? "[notice] Bootstrapped 100% (done)"
        @tor_pid = pid
        @tor_master = master
        puts "🚀 Spawned tor process"
        return @tor_pid
      end
    end
  end
end
