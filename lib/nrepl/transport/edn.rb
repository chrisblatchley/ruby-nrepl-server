require 'edn'

module NRepl
  module Transport
    module Edn
      class << self
        def handle(str)
          data = EDN.read str
          yield(data).to_edn
        end
      end
    end
  end
end