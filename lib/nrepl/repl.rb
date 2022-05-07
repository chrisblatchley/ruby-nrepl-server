require 'securerandom'

module NRepl
  class Repl
    class << self
      def run(session, code)
        wrap_stdout(code).merge({
          id: session[:id],
          ns: 'main',
          err: nil,
        })
      rescue Exception => e
        {
          id: session[:id],
          ns: 'main',
          out: '',
          err: e.to_s,
          value: nil
        }
      end

      def wrap_stdout(code)
        stdout, $stdout = $stdout, StringIO.new
        value = eval(read(code))
        {
          out: $stdout.string.dump,
          value: value
        }
      ensure
        $stdout = stdout
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