class Gerenciador
  require "socket"

  def initialize
    @server = TCPServer.open(5151)
    @clients = []
    main
  end

  def main
    loop do
      Thread.fork(@server.accept) do |client|
        @clients.push client
        send_command
        client.close
      end
    end
  end

  def send_command
    loop do
      command = gets.chomp
      @clients.each { |client| client.puts command }
    end
  end

end
Gerenciador.new.main
