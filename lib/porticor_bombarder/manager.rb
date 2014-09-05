PORTICOR_ENCRYPTED_ATTRIBUTES = YAML.load_file(File.join('config', 'db_encryption.yml'))

module PorticorBombarder

  class Manager

    def self.porticor_sandbox_registrar!
      PORTICOR_ENCRYPTED_ATTRIBUTES.each do |key, value|
        if value.is_a?(Hash)
          value.keys.each do |column_name|
            encrypt_and_alias_attribute(key.to_s, column_name, column_name)
          end
        elsif value.is_a?(Array)
          value.each do |column_name|
            encrypt_and_alias_attribute(key.to_s, "#{key}_#{column_name}", column_name)
          end
        end
      end
    end

    def self.encrypt_and_alias_attribute(c_name, pem_name, column_name, options= {})
      obj_class = c_name.classify.constantize

      obj_class.class_eval do
        encrypt_with_public_key column_name.to_sym,
                                key_pair: PorticorBombarder::Client.new.get_encryption_key(pem_name),
                                symmetric: options[:symmetric] || :never,
                                base64: options[:base64] || true
      end
      obj_class.instance_eval do
        alias_method "encrypted_#{column_name}".to_sym, column_name.to_sym
        define_method(column_name.to_sym) do
          send("encrypted_#{column_name}".to_sym).decrypt(PorticorBombarder::Client.new.get_encryption_key(pem_name))
        end
      end
    end

  end
end