require_relative 'transport/edn'

module NRepl
  module Transport
    class << self
      def handle(session, request, mode: :edn)
        transport = {
          edn: Edn
        }[mode]

        decoded = transport.decode(request)
        response = Ops.dispatch(session, decoded)

        transport.encode(response)
      end
    end
  end
end