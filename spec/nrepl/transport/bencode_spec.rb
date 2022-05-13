# frozen_string_literal: true

RSpec.describe NRepl::Transport::Bencode do
  describe 'stream' do
    [
      {
        input: 'de',
        yielded: {},
        output: 'dede'
      },
      {
        input: 'd2:op4:eval4:code3:1+2e',
        yielded: {},
        output: 'd2:op4:eval4:code3:1+2ede'
      },
      {
        input: 'd2:op5:clone2:id1:ae',
        yielded: { 'a' => 'b' },
        output: 'd2:op5:clone2:id1:aed1:a1:be'
      }
    ].each do |tc|
      context "with input #{tc[:input]}" do
        let(:io) { StringIO.new }

        before do
          io.write tc[:input]
          io.rewind
        end

        subject { NRepl::Transport::Bencode.stream(io) { tc[:yielded] } }

        it "returns #{tc[:response]}" do
          expect(subject).to be_nil
          io.rewind
          expect(io.read).to eq(tc[:output])
        end
      end
    end
  end
end
