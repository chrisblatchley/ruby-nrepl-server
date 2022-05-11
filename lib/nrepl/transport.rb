# frozen_string_literal: true

require_relative 'transport/bencode'
require_relative 'transport/edn'
require_relative 'transport/tty'

module NRepl
  module Transport
    class << self
      def handle(conn, session, mode: :bencode, **opts)
        transport = transport_module(mode)

        conn.write(transport.init)
        while (input = conn.gets)
          decoded = transport.decode(input)
          puts "<- #{decoded}" if opts[:verbose]

          response = Handler.dispatch(session, decoded)

          puts "-> #{response}" if opts[:verbose]
          conn.write transport.encode(response)
        end
      end

      def transport_module(mode)
        {
          bencode: Bencode,
          edn: Edn,
          tty: Tty
        }[mode]
      end
    end
  end
end
