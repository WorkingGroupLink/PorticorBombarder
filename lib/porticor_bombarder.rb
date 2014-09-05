require 'porticor_bombarder/version'
require 'porticor_bombarder/railtie' if defined?(Rails::Railtie)
require 'porticor_bombarder/exceptions'
require 'porticor_bombarder/client'
require 'porticor_bombarder/worker'
require 'porticor_bombarder/manager'

module PorticorBombarder

  def self.included(base)
    Worker.builder! #key_pair generator to Porticor
    Manager.porticor_sandbox_registrar! #attribute encryptor and aliaser
  end

end

ActiveRecord::Base.send(:include, PorticorBombarder)

