require 'git'

module Idler
  module GitBranch

    def current_branch
      Git.open(Dir.pwd).current_branch
    end

  end
end
