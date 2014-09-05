module PorticorBombarder
  class Engine < ::Rails::Engine
    isolate_namespace PorticorBombarder

    config.autoload_paths += %W(#{config.root}/lib/modules)

  end
end