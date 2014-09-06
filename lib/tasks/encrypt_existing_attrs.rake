require 'rake'
namespace :porticor_bombarder do
  PORTICOR_ENCRYPTED_ATTRIBUTES = YAML.load_file(File.join('config', 'porticor_attrs.yml'))

  desc 'encrypt existing attributes'
  task :encrypt => :environment do
    PORTICOR_ENCRYPTED_ATTRIBUTES.each do |key, value|
      obj_class = key.to_s.classify.constantize
      case true
        when value.is_a?(Hash)
          value.values.flatten.each do |column_name|
            obj_class.all.each do |obj|
              obj.send(column_name.to_sym)
              if (_match_data = obj.send(column_name.to_sym).match(/^##([\s\S]*)##/))
                obj.update(column_name => _match_data[1])
              end
            end
          end
        when value.is_a?(Array)
          value.each do |column_name|
            obj_class.all.each do |obj|
              obj.send(column_name.to_sym)
              if (_match_data = obj.send(column_name.to_sym).match(/^##([\s\S]*)##/))
                obj.update(column_name => _match_data[1])
              end
            end
          end
        else
      end
    end
  end

end
