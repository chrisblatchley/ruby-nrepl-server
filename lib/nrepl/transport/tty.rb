# frozen_string_literal: true

module NRepl
  module Transport
    module Tty
      class << self
        def init
          "Ruby #{RUBY_VERSION}\n#{prompt('main')}"
        end

        def decode(str)
          { op: 'eval', code: str }
        end

        def encode(response)
          "#{response[:out].undump}#{response[:value]}\n#{prompt(response[:ns])}"
        end

        private

        def prompt(namespace)
          "(#{namespace})=> "
        end
      end
    end
  end
end
