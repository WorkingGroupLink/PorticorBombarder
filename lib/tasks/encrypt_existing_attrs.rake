require 'rake'
namespace :porticor_bombarder do
  PORTICOR_ENCRYPTED_ATTRIBUTES = YAML.load_file(File.join('config', 'porticor_attrs.yml'))

  desc 'encrypt existing attributes with batches default size is 100'
  task :encrypt, [:batch_size] => :environment do |t, args|

    batch_size = args[:batch_size] || 100

    PORTICOR_ENCRYPTED_ATTRIBUTES.each do |key, value|

      obj_class = key.to_s.classify.constantize
      case true
        when value.is_a?(Hash)
          value.values.flatten.each do |column_name|
            obj_class.find_each(batch_size: batch_size) do |obj|
              if obj.send(column_name.to_sym) and (_match_data = obj.send(column_name.to_sym).match(/^##([\s\S]*)##/))
                begin
                  obj.update(column_name => _match_data[1])
                rescue Exception => e
                  puts "Got error message #{e.message} for #{obj.inspect}"
                end
              end
            end
          end
        when value.is_a?(Array)
          value.each do |column_name|
            obj_class.find_each(batch_size: batch_size) do |obj|
              if obj.send(column_name.to_sym) and (_match_data = obj.send(column_name.to_sym).match(/^##([\s\S]*)##/))
                begin
                  obj.update(column_name => _match_data[1])
                rescue Exception => e
                  puts "Got error message #{e.message} for #{obj.inspect}"
                end
              end
            end
          end
        else
          raise StandardError.new('while inspecting columns type in schema something went wrong.')
      end
    end
  end

end
