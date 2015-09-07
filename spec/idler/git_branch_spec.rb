require 'spec_helper'

describe Idler::GitBranch do

  before do
    class Dir
      def self.pwd
        'spec/supports'
      end
    end
  end

  describe '#current_branch' do

    subject do
      class DummyClass
        class << self
          include Idler::GitBranch
        end
      end
      DummyClass.current_branch
    end
    it { is_expected.to eq("development") }
  end
end
