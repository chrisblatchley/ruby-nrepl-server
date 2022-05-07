# frozen_string_literal: true

module NRepl
  module Session
    class << self
      def start
        {
          id: SecureRandom.uuid,
          binding: binding
        }
      end
    end
  end
end
