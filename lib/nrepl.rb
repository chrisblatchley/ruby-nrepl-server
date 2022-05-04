# frozen_string_literal: true

require_relative "nrepl/version"
require_relative "nrepl/server"
require_relative "nrepl/repl"

module NRepl
  class Error < StandardError; end

  def self.run
    opts = {} # skip parsing from command line for now

    ctx = Server.start({}, **opts)
    ctx[:server].accept.then do |c|
      Repl.run(c)
    end
    Server.stop(**ctx)
  end
end
