require 'porticor_bombarder/invigilator'
require 'porticor_bombarder/manager'

module PorticorBombarder

  class Railtie < Rails::Railtie
    initializer "porticor_bombarder.configure_rails_initialization" do
      PorticorBombarder::Worker.builder! #key_pair generator to Porticor
      PorticorBombarder::Invigilator.inspector!
      PorticorBombarder::Manager.porticor_sandbox_registrar!
    end

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), '..', 'tasks', '*.rake')].each { |f| load f }
    end
  end

end