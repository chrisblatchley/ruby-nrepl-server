# frozen_string_literal: true

module NRepl
  module Session
    class << self
      # create a session hash
      # @return [Hash]
      def start
        {
          id: SecureRandom.uuid,
          binding: binding
        }
      end
    end
  end
end
