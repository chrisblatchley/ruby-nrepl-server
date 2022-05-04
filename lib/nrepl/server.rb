require 'socket'

module NRepl
  class Server
    class << self
      def start(ctx, host: "0.0.0.0", port: "0", quiet: false)
        server = TCPServer.new(host, port)
        puts "starting server on port #{server.addr[1]}" unless quiet

        {server: server}
      end

      def stop(server:)
        server.close
      end
    end
  end
end