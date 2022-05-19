# frozen_string_literal: true

require 'securerandom'

module NRepl
  class Repl
    class << self
      # run code in a session
      #
      # @param session [Hash] the session
      # @param code [String] the code to eval
      # @return [Hash] {id:, ns:, err:, out:, value:}
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

      # capture anything written to stdout
      #
      # @param session [Hash] the session
      # @param code [String] the code to eval
      # @return [Hash] {out:, value:}
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

      # reader (Identity for now)
      #
      # @param str [String]
      # @return [String]
      def read(str)
        str
      end

      # eval code
      #
      # @param session [Hash]
      # @param ast [String] just a string for now
      # @return [Object] the result of evaluation
      def eval(session, ast)
        Kernel.eval ast, session[:binding]
      end
    end
  end
end
