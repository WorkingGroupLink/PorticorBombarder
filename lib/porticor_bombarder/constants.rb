module PorticorBombarder
  PORTICOR_CONFIGURATION = YAML.load_file(File.join('config', 'porticor.yml'))[Rails.env]
  PORTICOR_REQUIRED_OPTIONS = %w(api_key api_secret api_url)
  PORTICOR_ENCRYPTED_ATTRIBUTES = YAML.load_file(File.join('config', 'db_encryption.yml'))
  PORTICOR_STORAGE_PATH = File.join('porticor', Rails.env)
end