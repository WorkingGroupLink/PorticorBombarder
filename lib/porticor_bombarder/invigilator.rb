module PorticorBombarder
  class Invigilator

    def self.inspector!
      PORTICOR_ENCRYPTED_ATTRIBUTES.each do |key, value|
        columns = case true
                    when value.is_a?(Hash)
                      value.values.flatten
                    when value.is_a?(Array)
                      value
                    else
                      raise Error.new('while inspecting columns type in schema something went wrong.')
                  end
        validate(key, columns)
      end
    end

    def self.validate(model_name, columns)
      begin
        columns.each do |column_name|
          type_in_schema = model_name.to_s.classify.constantize.columns_hash[column_name].type
          puts "#{model_name.to_s.classify}'s column #{column_name} is not of type 'text' (is of type '#{type_in_schema}') and may lead to inadequate space while storing encrypted content." unless (type_in_schema == :text)
        end
      rescue Exception => e
        PorticorBombarder::PorticorLogger.logger.warn e.message
      end
    end

  end
end

