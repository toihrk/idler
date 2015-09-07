module Idler
  module DSL

    def branch(branch_name = nil, &block)
      raise Idler::NothingBranchNameError if branch_name.nil?
      Idler::Branch.new(branch_name, block)
    end

  end
end

extend Idler::DSL
