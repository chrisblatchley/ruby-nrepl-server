# frozen_string_literal: true

require 'securerandom'

module NRepl
  class Repl
    class << self
      def run(session, code) # rubocop:disable Metrics/MethodLength
        wrap_stdout(session, code).merge(
          {
            id: session[:id],
            ns: 'main',
            err: nil
          }
        )
      rescue Exception => e # rubocop:disable Lint/RescueException
        {
          id: session[:id],
          ns: 'main',
          out: '',
          err: e.to_s,
          value: nil
        }
      end

      def wrap_stdout(session, code)
        stdout, $stdout = $stdout, StringIO.new # rubocop:disable Style/ParallelAssignment
        value = self.eval(session, read(code))
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

      def eval(session, ast)
        Kernel.eval ast, session[:binding]
      end
    end
  end
end
