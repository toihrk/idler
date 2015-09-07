require 'idler'

RSpec.configure do |config|

  config.before(:each) do
    FileUtils.mv('spec/supports/git', 'spec/supports/.git')
  end

  config.after(:each) do
    FileUtils.mv('spec/supports/.git', 'spec/supports/git')
  end
end
