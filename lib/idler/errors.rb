module Idler
  class NothingBranchNameError < ArgumentError ; end
  class NotDetectBranchError   < ArgumentError ; end

  class NotYetAddBranchError < StandardError ; end
  class NotProcError         < StandardError ; end
end
