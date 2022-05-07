# frozen_string_literal: true

module NRepl
  module Ops
    # PROTOCOL = {
    #   'add-middleware' => method(:add_middleware)
    #   'clone' => method(:clone)
    #   'close' => method(:close)
    #   'completions' => method(:completions)
    #   'describe' => method(:describe)
    #   'eval' => method(:eval)
    #   'interrupt' => method(:interrupt)
    #   'load-file' => method(:load_file)
    #   'lookup' => method(:lookup)
    #   'ls-middleware' => method(:ls_middleware)
    #   'ls-sessions' => method(:ls_sessions)
    #   'sideloader-provide' => method(:sideloader_provide)
    #   'sideloader-start' => method(:sideloader_start)
    #   'stdin' => method(:stdin)
    #   'swap-middleware' => method(:swap_middleware)
    # }

    class << self
      def dispatch(session, request)
        case request[:op]
        when 'eval'
          self.eval(session, request[:code])
        else
          { status: 'done' }
        end
      end

      # rubocop:disable Lint/UnusedMethodArgument, Naming/MethodParameterName, Metrics/ParameterLists
      def add_middleware(middleware, extra_namespaces: [])
        {
          status: 'done', # or 'error'
          unresolved_middleware: []
        }
      end

      def clone(session_id: '')
        {
          new_session: ''
        }
      end

      def close(session)
        {}
      end

      def completions(prefix, complete_fn: 'My::Ns#completion', ns: 'main', options: {})
        {
          completions: [{ candidate: nil, type: nil }]
        }
      end

      def describe(**opts)
        {
          aux: {},
          ops: {},
          versions: {}
        }
      end

      def eval(session, code, column: 0, eval: 'Kernel#eval', file: '', id: SecureRandom.uuid, line: 0, ns: 'main', read_cond: {}) # rubocop:disable Layout/LineLength
        Repl.run(session, code)
        # {
        #   ex: nil,
        #   ns: ns,
        #   root_ex: nil,
        #   value: nil
        # }
      end

      def interrupt(session, interrupt_id: '')
        {
          status: 'session-idle' # or 'session-id-mismatch, 'interrupt-id-mismatch'
        }
      end

      def load_file(file, file_name: '', file_path: '')
        {
          ex: nil,
          root_ex: nil,
          value: nil
        }
      end

      def lookup(sym, lookup_fn: 'My::Ns#lookup')
        {
          info: {}
        }
      end

      def ls_middleware
        {
          middleware: []
        }
      end

      def ls_sessions
        {
          sessions: []
        }
      end

      def sideloader_provide(content, name, session, type)
        {}
      end

      def sideloader_start(session)
        {
          status: 'sideloader-lookup'
        }
      end

      def stdin(stdin)
        {
          status: 'done' # or 'need-input'
        }
      end

      def swap_middleware(middleware)
        {
          status: 'done', # or 'error'
          unresolved_middleware: []
        }
      end
      # rubocop:enable Lint/UnusedMethodArgument, Naming/MethodParameterName, Metrics/ParameterLists
    end
  end
end
