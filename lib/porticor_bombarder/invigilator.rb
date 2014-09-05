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
      columns.each do |column_name|
        type_in_schema = model_name.to_s.classify.constantize.columns_hash[column_name].type
        puts %Q(
                  Warning: for ActiveRecord::Base.descendants classname #{model_name}
                  to be encrypeted column_name #{column_name}
                  is of type #{type_in_schema}
             ) if (type_in_schema != :text)
      end
    end

  end
end

