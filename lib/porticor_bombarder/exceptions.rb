module PorticorBombarder
  class InvalidOptions < StandardError;
  end

  class Error < StandardError;
  end

  class DuplicateItemError < Error;
  end

  class KeyPairFileSystemNotAvailable < StandardError
  end

  class KeyPairCacheNotAvailable < StandardError
  end

end