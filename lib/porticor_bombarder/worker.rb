module PorticorBombarder

  class Worker

    def self.builder!
      PORTICOR_ENCRYPTED_ATTRIBUTES.each do |key, value|
        pem_names = case true
                      when value.is_a?(Hash)
                        value.keys.collect { |pem_name| pem_name.to_s }
                      when value.is_a?(Array)
                        value.collect { |column_name| "#{key}_#{column_name}" }
                      else
                        raise Error.new('some thing wrong.')
                    end
        pem_generator(pem_names)
      end
    end

    def self.pem_generator(pem_file_names)
      pem_file_names.each do |pem_file_name|
        key_pair_string = PorticorBombarder::Client.new.find_or_create_encryption_key(pem_file_name)
        backup(pem_file_name, key_pair_string) if PORTICOR_CONFIGURATION['backup_enabled']
      end
    end

    #Todo backup key_pair to file systems later it will be on AWS-S3 bucket
    def self.backup(filename, content)
      FileUtils.mkdir_p PORTICOR_STORAGE_PATH
      file_name_with_path = "#{PORTICOR_STORAGE_PATH}/#{filename}.pem"
      File.open(file_name_with_path, 'w+') do |f|
        f.write(content)
      end unless File.exists?(file_name_with_path)
    end

  end

end