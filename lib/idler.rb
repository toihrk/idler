require 'idler/version'
require 'idler/errors'
require 'idler/install'
require 'idler/git_branch'
require 'idler/branch'
require 'idler/descriptions'
require 'idler/workers'

module Idler
  class << self

    include GitBranch

    def descriptions
      @descriptions ||= Descriptions.new
    end

    def workers
      @workers ||= Workers.new
    end

    def run(argv = [])
      argvs = []
      argvs.push *ARGV.dup
      argvs.push *argv

      Install.copy      if argvs.include?('init')
      descriptions.info if argvs.include?('info')

      if argvs.empty?
        workers.run(current_branch)
      else
        workers.run(argvs.first) unless ['init', 'info'].include? argvs.first
      end
    end

  end
end
