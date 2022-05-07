# frozen_string_literal: true

require 'edn'

module NRepl
  module Transport
    module Edn
      class << self
        def init
        end

        def decode(str)
          EDN.read str
        end

        def encode(response)
          response.to_edn
        end
      end
    end
  end
end
