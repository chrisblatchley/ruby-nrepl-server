# frozen_string_literal: true

RSpec.describe NRepl::Transport do
  describe 'handle' do
    let(:input) { '' }
    let(:io) { StringIO.new(input) }
    let(:mode) { :fake }
    let(:fake_transport) { double('Fake', stream: nil) }

    before { stub_const 'NRepl::Transport::Fake', fake_transport }

    subject { NRepl::Transport.handle(io, mode: mode) }

    it 'sends handler dispatch to transport stream' do
      expect(subject).to be_nil
    end
  end
end
