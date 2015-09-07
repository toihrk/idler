module Idler
  module Install

    def self.copy
      src  = File.expand_path(File.dirname(__FILE__) + '/../templates/idler.rb')
      dest = Dir.pwd + "/.idler.rb"
      FileUtils.copy src, dest
    end

  end
end
