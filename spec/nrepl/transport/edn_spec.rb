# frozen_string_literal: true

RSpec.describe NRepl::Transport::Edn do
  describe 'stream' do
    [
      {
        input: '{}',
        yielded: {},
        output: '{}{}'
      },
      {
        input: '{:op "example"}',
        yielded: { status: :done },
        output: '{:op "example"}{:status :done}'
      }
    ].each do |tc|
      context "with input #{tc[:input]}" do
        let(:io) { StringIO.new }

        before do
          io.write tc[:input]
          io.rewind
        end

        subject { NRepl::Transport::Edn.stream(io) { tc[:yielded] } }

        it "returns #{tc[:response]}" do
          expect(subject).to be_nil
          io.rewind
          expect(io.read).to eq(tc[:output])
        end
      end
    end
  end
end
