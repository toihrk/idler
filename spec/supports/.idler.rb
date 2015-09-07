require 'idler/dsl'

branch 'master' do
  desc   'master description'
  detail 'master detail'
  worker do
    `cat master`
  end
end

branch 'development' do
  desc   'development description'
  detail 'development detail'
  worker do
    `cat development`
  end
end
