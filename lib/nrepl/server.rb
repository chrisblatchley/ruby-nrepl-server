# frozen_string_literal: true

require 'socket'

module NRepl
  class Server
    class << self
      # start a TCPServer
      #
      # @option host [String] hostname
      # @option port [String] port - default to '0' for a random available port
      # @option mode [Symbol] :bencode (default), :edn, or :tty
      # @option verbose [Boolean] enable verbose mode
      #
      # @return [Hash] server: tcp server instance, config: {host:, port:, mode:, verbose:}
      def start(host: '0.0.0.0', port: '0', mode: :bencode, verbose: false)
        TCPServer.new(host, port).then do |server|
          port = server.addr[1]

          puts greet(host, port)
          File.write('nrepl.port', "#{port}\n")

          {
            server: server,
            config: { host: host, port: port, mode: mode, verbose: verbose }
          }
        end
      end

      # accept a connection and start handling requests
      #
      # @option server [TCPServer] the server instance
      # @option config [Hash] {host:, port:, mode:, verbose:}
      def listen_and_serve(server:, config:)
        server.accept.then do |io|
          Transport.handle(io, **config.slice(:mode, :verbose))
        end
      end

      # close the server and delete the file
      #
      # @option server [TCPServer] the server to stop
      def stop(server:, **_)
        File.delete('nrepl.port')
        server.close
        {}
      end

      # the connection welcome message
      #
      # @param host [String] the hostname
      # @param port [String] the port
      # @return [String] the greeting message
      def greet(host, port)
        "nREPL server started on port #{port} on host #{host} - nrepl://#{host}:#{port}"
      end
    end
  end
end
