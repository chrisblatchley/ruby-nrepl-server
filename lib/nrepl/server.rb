require 'socket'

module NRepl
  class Server
    class << self
      def start(host: "0.0.0.0", port: "0", quiet: false)
        server = TCPServer.new(host, port)
        port = server.addr[1]
        greet = "nREPL server started on port #{port} on host #{host} - nrepl://#{host}:#{port}"
        puts greet

        {
          server: server,
          greet: greet
        }
      end

      def listen_and_serve(server:, greet:)
        conn = server.accept
        session = NRepl::Session.start
        conn.puts greet
        while data = conn.gets
          conn.puts Transport.handle(session, data)
        end
      end

      def stop(server:)
        server.close
      end
    end
  end
end