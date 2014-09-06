module PorticorBombarder
  PORTICOR_CONFIGURATION = YAML.load_file(File.join('config', 'porticor.yml'))[Rails.env]
  PORTICOR_ENCRYPTED_ATTRIBUTES = YAML.load_file(File.join('config', 'porticor_attrs.yml'))
  PORTICOR_STORAGE_PATH = File.join('porticor', Rails.env)
end