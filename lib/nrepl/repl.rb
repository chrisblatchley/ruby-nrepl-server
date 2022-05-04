require 'securerandom'

module NRepl
  class Repl
    class << self
      def run(conn)
        while input = conn.gets
          conn.puts({
            id: SecureRandom.uuid,
            ns: 'main',
            out: '',
            err: '',
            value: eval(read(input))
          })
        end
      end

      def read(str, fmt: :ruby)
        case fmt
        when :ruby
          Kernel.eval(str).tap { |h| raise "Not a hash" unless h.is_a?(Hash) }
        else
          {op: 'eval', code: ''}
        end
      end

      def eval(ast)
        case ast[:op]
        when 'eval'
          Kernel.eval(ast[:code])
        end
      rescue StandardError => err
        "Error: #{err.to_s}"
      rescue Exception => e
        "Fatal: #{e.to_s}"
      end
    end
  end
end