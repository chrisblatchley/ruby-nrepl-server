require_relative 'transport/edn'

module NRepl
  module Transport
    class << self
      def handle(request, mode: :edn)
        data = case mode
        when :edn
          Edn.handle(request) { |data| Repl.run(**data) }
        end
      end
    end
  end
end