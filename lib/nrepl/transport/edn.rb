# frozen_string_literal: true

require 'edn'

module NRepl
  module Transport
    module Edn
      class << self
        def stream(io)
          while (decoded = EDN.read(io, nil))
            io.write (yield decoded).to_edn
          end
        end
      end
    end
  end
end
