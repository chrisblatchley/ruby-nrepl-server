# frozen_string_literal: true

require 'socket'

module NRepl
  class Server
    class << self
      def start(host: '0.0.0.0', port: '0')
        TCPServer.new(host, port).then do |server|
          port = server.addr[1]

          puts greet(host, port)
          File.write('nrepl.port', "#{port}\n")

          {
            server: server,
            config: { host: host, port: port }
          }
        end
      end

      def listen_and_serve(server:, config:)
        server.accept.then do |conn|
          NRepl::Session.start.then do |session|
            conn.puts greet(config[:host], config[:port])
            while (data = conn.gets)
              conn.puts Transport.handle(session, data)
            end
          end
        end
      end

      def stop(server:, **_)
        File.delete('nrepl.port')
        server.close
        {}
      end

      def greet(host, port)
        "nREPL server started on port #{port} on host #{host} - nrepl://#{host}:#{port}"
      end
    end
  end
end
