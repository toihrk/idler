require 'spec_helper'

describe Idler::Descriptions do

  describe '.new' do
    subject { described_class.new }

    it { is_expected.to be_a Idler::Descriptions }
    it '@descriptions should be set {}' do
       expect(subject.instance_variable_get(:@descriptions)).to eq({})
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
      it { is_expected.to eq({}) }

      it '@descriptions should be set branch with blank hash' do
        subject
        expect(instance.instance_variable_get(:@descriptions)).to eq({'test'=> {}})
      end
    end
  end

  describe '#add_desc' do
    let(:instance) { described_class.new }
    let(:branch)   { nil }
    let(:desc)     { nil }

    subject { instance.add_desc branch, desc }

    context 'not yet #add_branch' do
      let(:branch) { 'test' }
      it { expect { subject }.to raise_error(Idler::NotYetAddBranchError) }
    end

    context 'without branch name' do
      before  { instance.add_branch 'test' }
      it { expect { subject }.to raise_error(Idler::NothingBranchNameError) }
    end

    context 'with branch name' do
      let(:branch) { 'test' }
      let(:desc)   { 'test branch description' }

      before  { instance.add_branch branch }
      it { expect { subject }.to_not raise_error }
      it { is_expected.to eq(desc) }

      it '@descriptions should be set test branch description' do
        subject
        expected_hash = {
          'test' => {
            description: desc
          }
        }
        expect(instance.instance_variable_get(:@descriptions)).to match(expected_hash)
      end
    end

  end

  describe '#add_detail' do
    let(:instance) { described_class.new }
    let(:branch)   { nil }
    let(:detail)     { nil }

    subject { instance.add_detail branch, detail }

    context 'not yet #add_branch' do
      let(:branch) { 'test' }
      it { expect { subject }.to raise_error(Idler::NotYetAddBranchError) }
    end

    context 'without branch name' do
      before  { instance.add_branch 'test' }
      it { expect { subject }.to raise_error(Idler::NothingBranchNameError) }
    end

    context 'with branch name' do
      let(:branch) { 'test' }
      let(:detail)   { 'test branch detail' }

      before  { instance.add_branch branch }
      it { expect { subject }.to_not raise_error }
      it { is_expected.to eq(detail) }

      it '@descriptions should be set test branch description' do
        subject
        expected_hash = {
          'test' => {
            detail: detail
          }
        }
        expect(instance.instance_variable_get(:@descriptions)).to match(expected_hash)
      end
    end

  end

  describe '#info' do
    let(:instance) { described_class.new }
    subject { instance.info }

    context 'without branch descriptions' do
      it 'should be print nothing branch' do
        expect { subject }.to output("--- Branches Info ---\n").to_stdout
      end
    end

    context 'with branch' do
      before do
        instance.add_branch 'test'
      end
      it 'should be print branches' do
        expect { subject }.to output("--- Branches Info ---\n* \e[1mtest\e[0m\n").to_stdout
      end
    end

  end

end
