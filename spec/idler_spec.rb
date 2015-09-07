require 'spec_helper'

describe Idler do
  it 'has a version number' do
   expect(Idler::VERSION).not_to be nil
  end

  describe '.descriptions' do
    subject { Idler.descriptions }
    it { is_expected.to be_instance_of(Idler::Descriptions) }
  end

  describe '.workers' do
    subject { Idler.workers }
    it { is_expected.to be_instance_of(Idler::Workers) }
  end

  describe '.run' do
    let(:argv)  { nil }

    subject { Idler.run(argv) }

    context 'init action' do
      let(:argv) { [ 'init' ] }

      before do
        class Dir
          def self.pwd
            @tmpdir ||= Dir.mktmpdir
          end
        end
      end

      it 'should copy .idler.rb' do
        expect(File.exist?(Dir.pwd+"/.idler.rb")).to be_truthy
      end
    end

    context 'info action' do
      let(:argv) { [ 'info' ] }
      before { Idler.remove_instance_variable(:@descriptions) }
      it 'should be print nothing branch' do
        expect { subject }.to output("--- Branches Info ---\n").to_stdout
      end
    end

    context 'run specified branch' do
      let(:argv) { [ 'test' ] }
      context 'not found' do
        before { Idler.remove_instance_variable(:@workers) }
        it { is_expected.to be_nil }
      end

      context 'success' do
        let(:workers) do
          workers_instance = Idler::Workers.new
          workers_instance.instance_variable_set(:@workers, {'test' => Proc.new { 'ok' } })
          workers_instance
        end
        before { Idler.instance_variable_set(:@workers,  workers) }
        it { is_expected.to eq('ok') }
      end
    end

    context 'run current_branch' do
      before do
        class Dir
          def self.pwd
            'spec/supports'
          end
        end
      end

      context 'not found' do
        before { Idler.remove_instance_variable(:@workers) }
        it { is_expected.to be_nil }
      end

      context 'success' do
        let(:workers) do
          workers_instance = Idler::Workers.new
          workers_instance.instance_variable_set(:@workers, {'development' => Proc.new { 'ok' } })
          workers_instance
        end
        before { Idler.instance_variable_set(:@workers,  workers) }
        it { is_expected.to eq('ok') }
      end
    end
  end
end
