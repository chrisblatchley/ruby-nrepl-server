# frozen_string_literal: true

require 'bencode'

module NRepl
  module Transport
    module Bencode
      class << self
        def init; end

        def decode(str)
          stream = BEncode::Parser.new(StringIO.new(str))

          stream.parse!.transform_keys(&:to_sym)
        rescue BEncode::DecodeError => e
          puts "BEncode Decode Error: #{e}"
          {}
        end

        def encode(response)
          response.transform_values { |v| v.nil? ? '' : v }.bencode
        rescue BEncode::EncodeError => e
          puts "BEncode Decode Error: #{e}"
          'd6:status5:errore'
        end
      end
    end
  end
end
