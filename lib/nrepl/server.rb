require 'socket'

module NRepl
  class Server
    class << self
      def start(ctx, host: "0.0.0.0", port: "0", quiet: false)
        server = TCPServer.new(host, port)
        puts "starting server on port #{server.addr[1]}" unless quiet

        {server: server}
      end

      def listen_and_serve(server:)
        conn = server.accept
        session = NRepl::Session.start
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