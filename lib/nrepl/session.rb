# frozen_string_literal: true

module NRepl
  module Session
    class << self
      # create a session hash
      # @return [Hash]
      def start(mode: :bencode)
        {
          id: SecureRandom.uuid,
          binding: binding,
          mode: mode
        }
      end
    end
  end
end
