require 'securerandom'

module NRepl
  class Repl
    class << self
      def run(session, code)
        {
          id: session[:id],
          ns: 'main',
          out: '',
          err: nil,
          value: eval(read(code))
        }
      rescue Exception => e
        {
          id: session[:id],
          ns: 'main',
          out: '',
          err: e.to_s,
          value: nil
        }
      end

      def read(str)
        str
      end

      def eval(ast)
        Kernel.eval ast
      end
    end
  end
end