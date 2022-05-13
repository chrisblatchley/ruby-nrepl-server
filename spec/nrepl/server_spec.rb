# frozen_string_literal: true

RSpec.describe NRepl::Server do
  describe 'start' do
    let(:opts) { {} }
    subject { NRepl::Server.start(**opts) }
    before { allow(File).to receive(:write).with('nrepl.port', any_args) }

    it { is_expected.to have_key(:server) }
    it { is_expected.to have_key(:config) }
  end

  describe 'listen_and_serve' do
    let(:server) { double }
    let(:io) { double }
    let(:opts) { { server: server, config: { mode: :tty } } }

    subject { NRepl::Server.listen_and_serve(**opts) }

    it 'accepts a connection and calls into transport handler' do
      expect(server).to receive(:accept).and_return(io)
      expect(NRepl::Transport).to receive(:handle).with(io, mode: :tty)
      expect(subject).to eq(nil)
    end
  end

  describe 'stop' do
    let(:server) { double }
    let(:opts) { { server: server } }

    subject { NRepl::Server.stop(**opts) }

    before { expect(server).to receive(:close) }
    before { allow(File).to receive(:delete).with('nrepl.port') }

    it { is_expected.to eq({}) }
  end

  describe 'greet' do
    subject { NRepl::Server.greet('localhost', 69420) }
    it { is_expected.to eq('nREPL server started on port 69420 on host localhost - nrepl://localhost:69420') }
  end
end
