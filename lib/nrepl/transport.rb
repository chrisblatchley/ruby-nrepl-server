# frozen_string_literal: true

require_relative 'transport/bencode'
require_relative 'transport/edn'
require_relative 'transport/tty'

module NRepl
  module Transport
    class << self
      # start a session and start streaming from the socket using a specified protocol
      #
      # @param io [IO] an IO stream
      # @option mode [Symbol] :bencode (default), :edn, or :tty
      def handle(io, mode: :bencode, **_opts)
        session = Session.start

        const_get(mode.capitalize).stream(io) do |data|
          Handler.dispatch(session, data)
        end
      end

      # convert transport protocol symbol to correct transport module
      #
      # @param mode [Symbol] :bencode, :edn, or :tty
      # @return [Module] the transport module
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
