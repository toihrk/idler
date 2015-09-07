require 'spec_helper'
require './lib/idler/dsl'

module Idler
  class DummyDSL
    include Idler::DSL

    describe Idler::DSL do
      let(:dsl) { DummyDSL.new }

      describe '#branch' do
        let(:branch_name) { nil }
        let(:block)       { Proc.new { nil } }

        subject { dsl.branch branch_name, &block }

        context 'without branch name' do
          it { expect{ subject }.to raise_error(NothingBranchNameError) }
        end

        context 'with branch name' do
          let(:branch_name) { 'test' }

          it { expect{ subject }.to_not raise_error }
          it { is_expected.to be_a Idler::Branch }
        end

      end

    end
  end
end
