require 'logger'

module PorticorBombarder
  class PorticorLogger < Logger
    file = File.open(File.join('log', "porticor_bombarder_#{Rails.env}.log"), File::WRONLY | File::APPEND | File::CREAT)
    @@logger ||= new(file, 10, 1024000)
    @@logger.level = DEBUG

    def self.logger
      @@logger
    end

  end
end

