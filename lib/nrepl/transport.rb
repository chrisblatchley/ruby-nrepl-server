require_relative 'transport/edn'

module NRepl
  module Transport
    class << self
      def handle(session, request, mode: :edn)
        data = case mode
        when :edn
          Edn.handle(request)
        end

        Ops.dispatch(session, data).to_edn
      end
    end
  end
end