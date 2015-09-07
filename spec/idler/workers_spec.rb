require 'spec_helper'

describe Idler::Workers do

  describe '.new' do
    subject { described_class.new }

    it { is_expected.to be_a Idler::Workers }
    it '@workers should be set {}' do
      expect(subject.instance_variable_get(:@workers)).to eq({})
    end
  end

  describe '#add_branch' do
    let(:instance) { described_class.new }
    let(:branch)   { nil }
    subject { instance.add_branch(branch) }

    context 'without branch name' do
      it { expect { subject }.to raise_error(Idler::NothingBranchNameError) }
    end

    context 'with branch name' do
      let(:branch) { 'test' }

      it { expect { subject }.to_not raise_error }
      it { is_expected.to be_nil }

      it '@workers should be set branch' do
        subject
        expect(instance.instance_variable_get(:@workers)).to eq({'test'=>nil})
      end
    end

  end

  describe '#add_worker' do
    let(:instance) { described_class.new }
    let(:branch)   { nil }
    let(:block)    { Proc.new { nil } }

    subject { instance.add_worker(branch, block) }

    context 'not yet #add_branch' do
      let(:branch) { 'test' }
      it { expect { subject }.to raise_error(Idler::NotYetAddBranchError) }
    end

    context 'without branch_name' do
      before { instance.add_branch 'test' }
      it { expect { subject }.to raise_error(Idler::NothingBranchNameError) }
    end

    context 'without block' do
      before { instance.add_branch 'test' }
      let(:branch) { 'test' }
      let(:block)  { nil }
      it { expect { subject }.to raise_error(Idler::NotProcError) }
    end

    context 'with branch' do
      let(:branch) { 'test' }

      before  { instance.add_branch branch }
      it { expect { subject }.to_not raise_error }

      it 'should eq give proc' do
        is_expected.to eq(block)
      end

      it '@workers should be set test branch worker' do
        subject
        expected_hash = {
          'test' => block
        }
        expect(instance.instance_variable_get(:@workers)).to match(expected_hash)
      end
    end

  end

  describe '#run' do
    let(:instance) { described_class.new }
    let(:branch)   { nil }
    let(:block)    { Proc.new { branch } }

    subject { instance.run branch }

    context 'without branch' do
      it { expect { subject }.to raise_error(Idler::NothingBranchNameError) }
    end

    context 'with branch' do
      let(:branch) { 'test' }
      before do
        instance.add_branch branch
        instance.add_worker branch, block
      end

      it { expect { subject }.to_not raise_error }
      it { is_expected.to eq(branch) }
    end

  end
end
