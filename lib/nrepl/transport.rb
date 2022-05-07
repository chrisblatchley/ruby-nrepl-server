# frozen_string_literal: true

require_relative 'transport/edn'
require_relative 'transport/tty'

module NRepl
  module Transport
    class << self
      def handle(conn, session, mode: :edn)
        transport = {
          edn: Edn,
          tty: Tty
        }[mode]

        conn.write(transport.init)

        while (input = conn.gets)
          decoded = transport.decode(input)
          response = Ops.dispatch(session, decoded)
          conn.write transport.encode(response)
        end
      end
    end
  end
end
