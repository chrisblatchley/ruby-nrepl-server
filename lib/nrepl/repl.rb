require 'securerandom'

module NRepl
  class Repl
    class << self
      def run(op:, code:)
        {
          id: SecureRandom.uuid,
          ns: 'main',
          out: '',
          err: '',
          value: eval(read(code))
        }
      end

      def read(str)
        str
      end

      def eval(ast)
        Kernel.eval ast
      rescue StandardError => err
        "Error: #{err.to_s}"
      rescue Exception => e
        "Fatal: #{e.to_s}"
      end
    end
  end
end