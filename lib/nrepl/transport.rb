# frozen_string_literal: true

require_relative 'transport/bencode'
require_relative 'transport/edn'
require_relative 'transport/tty'

module NRepl
  module Transport
    class << self
      def handle(io, mode: :bencode, **_opts)
        session = Session.start

        const_get(mode.capitalize).stream(io) do |data|
          Handler.dispatch(session, data)
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
