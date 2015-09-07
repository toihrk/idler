require 'spec_helper'

describe Idler::Branch do

  describe '.new' do
    let(:branch) { nil }
    let(:block)  { Proc.new { nil }  }
    subject { described_class.new(branch, block) }

    context 'with nil block' do
      let(:branch) { 'test' }
      let(:block)  { Proc.new { nil }  }

      it { expect { subject }.to_not raise_error }
      it { is_expected.to be_a Idler::Branch }

      it 'instance variable @branch should be set "test"' do
        expect(subject.instance_variable_get(:@branch)).to eq('test')
      end

      it 'Descriptions should be set branches' do
        expect(Idler.descriptions.instance_variable_get(:@descriptions)).to eq({ "test" => {}})
      end

      it 'Workers should be set branches' do
        expect(Idler.workers.instance_variable_get(:@workers)).to eq({ "test" => nil })
      end
    end

    context 'with block' do
      let(:branch) { 'test' }

      let(:block) do
        Proc.new do
          desc "test description"
          detail "test detail"
          worker do
            nil
          end
        end
      end

      it { expect { subject }.to_not raise_error }
      it { is_expected.to be_a Idler::Branch }

      it 'instance variable @branch should be set "test"' do
        expect(subject.instance_variable_get(:@branch)).to eq('test')
      end

      it 'Descriptions should be set branches' do
        expected_hash = {
          "test" => {
            description: 'test description',
            detail:      'test detail'
          }
        }
        expect(Idler.descriptions.instance_variable_get(:@descriptions)).to match(expected_hash)
      end

      it 'Workers should be set branches' do
        expect(Idler.workers.instance_variable_get(:@workers)).to_not be_nil
      end
    end

    context 'without block' do
      let(:branch) { 'test' }
      let(:block)  { nil }

      it { expect { subject }.to_not raise_error }
      it { is_expected.to be_a Idler::Branch }

      it 'instance variable @branch should be set "test"' do
        expect(subject.instance_variable_get(:@branch)).to eq('test')
      end

      it 'Descriptions should be set branches' do
        expect(Idler.descriptions.instance_variable_get(:@descriptions)).to eq({ "test" => {}})
      end

      it 'Workers should be set branches' do
        expect(Idler.workers.instance_variable_get(:@workers)).to eq({ "test" => nil })
      end
    end

    context 'without branch' do
      let(:branch) { nil }
      let(:block)  { nil }

      it { expect { subject }.to raise_error(Idler::NotDetectBranchError) }
    end

  end

  describe '#desc' do
    let(:instance) { described_class.new('test') }
    let(:desc)     { 'test description' }
    subject { instance.desc(desc) }

    it { is_expected.to eq(desc) }
  end

  describe '#detail' do
    let(:instance) { described_class.new('test') }
    let(:detail)   { 'test detail' }
    subject { instance.detail(detail) }

    it { is_expected.to eq(detail) }
  end

  describe '#worker' do
    let(:instance) { described_class.new('test') }
    let(:worker)   { Proc.new { nil } }
    subject { instance.worker(&worker) }

    it 'should eq given block' do
      is_expected.to eq(worker)
    end
  end

end
