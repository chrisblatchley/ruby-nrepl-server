require 'edn'

module NRepl
  module Transport
    module Edn
      class << self
        def handle(str)
          EDN.read str
        end
      end
    end
  end
end