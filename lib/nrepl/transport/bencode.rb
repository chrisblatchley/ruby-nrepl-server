# frozen_string_literal: true

require 'bencode'

module NRepl
  module Transport
    module Bencode
      class << self
        def stream(io)
          stream = BEncode::Parser.new(io)
          while (decoded = stream.parse!.transform_keys(&:to_sym))
            io.write encode(yield decoded)
          end
        rescue BEncode::DecodeError, BEncode::EncodeError => e
          puts e
        end

        private

        def encode(response)
          response.transform_values { |v| v.nil? ? '' : v }.bencode
        end
      end
    end
  end
end
