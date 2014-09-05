require 'logger'

module PorticorBombarder
  class PorticorLogger < Logger

    @@porticor_logger ||= Logger.new(File.open(File.join('log', "porticor_bombarder_#{Rails.env}.log"), 'a+'))
    @@porticor_logger.level = 2

    def self.porticor_logger
      @@porticor_logger
    end

  end
end

