# frozen_string_literal: true

RSpec.describe NRepl::Transport::Tty do
  describe 'stream' do
    [
      {
        input: '',
        yielded: { out: '', value: nil, ns: 'main' },
        output: "Ruby #{RUBY_VERSION}\n(main)=> "
      }
    ].each do |tc|
      context "with input #{tc[:input]}" do
        let(:io) { StringIO.new }

        subject { NRepl::Transport::Tty.stream(io) { tc[:yielded] } }

        it "returns #{tc[:response]}" do
          expect(subject).to be_nil
          io.rewind
          expect(io.read).to eq(tc[:output])
        end
      end
    end
  end
end
