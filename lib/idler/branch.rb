module Idler
  class Branch

    def initialize(branch_name = nil, block = nil)
      raise Idler::NotDetectBranchError if branch_name.nil?
      @branch = branch_name

      descriptions.add_branch branch_name
      workers.add_branch      branch_name

      self.instance_eval &block unless block.nil?
    end

    def desc(description)
      descriptions.add_desc @branch, description
    end

    def detail(note)
      descriptions.add_detail @branch, note
    end

    def worker(&block)
      workers.add_worker @branch, block
    end

    private

    def descriptions
      Idler.descriptions
    end

    def workers
      Idler.workers
    end

  end
end
