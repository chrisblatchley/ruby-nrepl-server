# frozen_string_literal: true

require_relative 'nrepl/version'
require_relative 'nrepl/server'
require_relative 'nrepl/repl'
require_relative 'nrepl/transport'
require_relative 'nrepl/session'
require_relative 'nrepl/handler'

module NRepl
  class Error < StandardError; end

  # run an NRepl server
  # @option host [String] hostname
  # @option port [String] port - default to '0' for a random available port
  # @option mode [Symbol] :bencode (default), :edn, or :tty
  # @option verbose [Boolean] enable verbose mode
  def self.run(**opts)
    ctx = Server.start(**opts)

    Server.listen_and_serve(**ctx)

    Server.stop(**ctx)
  end
end
