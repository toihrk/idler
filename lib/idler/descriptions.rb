module Idler
  class Descriptions

    def initialize
      @descriptions = {}
    end

    def add_branch(branch_name = nil)
      raise NothingBranchNameError if branch_name.nil?
      @descriptions[branch_name] = {}
    end

    def add_desc(branch_name = nil, desc = "")
      raise NothingBranchNameError if branch_name.nil?
      raise NotYetAddBranchError   unless @descriptions.key?(branch_name)
      @descriptions[branch_name][:description] = desc
    end

    def add_detail(branch_name = nil, detail = "")
      raise NothingBranchNameError if branch_name.nil?
      raise NotYetAddBranchError unless @descriptions.key?(branch_name)
      @descriptions[branch_name][:detail] = detail
    end

    def info
      puts "--- Branches Info ---"

      @descriptions.each do |branch, info|
        print "* \e[1m#{branch}\e[0m"

        if info[:description]
          puts " - #{info[:description]}"
        else
          print "\n"
        end

        puts "#{info[:detail]}\n" if info[:detail]
      end
    end

  end
end
