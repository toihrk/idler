module Idler
  class Workers

    def initialize
      @workers = {}
    end

    def add_branch(branch_name = nil)
      raise NothingBranchNameError if branch_name.nil?
      @workers[branch_name] = nil
    end

    def add_worker(branch_name = nil, block = nil)
      raise NothingBranchNameError if branch_name.nil?
      raise NotYetAddBranchError   unless @workers.key?(branch_name)
      raise NotProcError           unless block.class == Proc
      @workers[branch_name] = block
    end

    def run(branch_name = nil)
      raise NothingBranchNameError if branch_name.nil?
      @workers[branch_name].call   if @workers.key?(branch_name)
    end

  end
end
