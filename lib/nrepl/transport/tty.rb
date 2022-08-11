# frozen_string_literal: true

module NRepl
  module Transport
    module Tty
      class << self
        def stream(io)
          io.write "Ruby #{RUBY_VERSION}\n#{prompt('main')}"

          while (input = io.gets)
            io.write encode(yield({ op: 'eval', code: input }))
          end
        end

        def encode(response)
          "#{response[:err]}#{response[:out].undump}#{response[:value]}\n#{prompt(response[:ns])}"
        end

        private

        def prompt(namespace)
          "(#{namespace})=> "
        end
      end
    end
  end
end
