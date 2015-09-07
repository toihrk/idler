require 'tmpdir'

describe Idler::Install do

  before do
    class Dir
      def self.pwd
        @tmpdir ||= Dir.mktmpdir
      end
    end
  end

  describe '.copy' do
    subject { Idler::Install.copy }
    it 'should be copy .idler.rb' do
      subject
      expect(File.exist?(Dir.pwd+"/.idler.rb")).to be_truthy
    end
  end

end
