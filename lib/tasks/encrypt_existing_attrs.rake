require 'rake'
namespace :porticor_bombarder do
  PORTICOR_ENCRYPTED_ATTRIBUTES = YAML.load_file(File.join('config', 'db_encryption.yml'))

  desc 'encrypt existing attributes'
  task :encrypt => :environment do
    PORTICOR_ENCRYPTED_ATTRIBUTES.each do |key, value|
      obj_class = key.to_s.classify.constantize
      case true
        when value.is_a?(Hash)
          value.values.each do |column_name|
            obj_class.all.each do |obj|
              # obj.save!
              # obj.reload
              # puts obj.inspect
              # puts "encrypted_#{column_name}"
              # puts obj.send("encrypted_#{column_name}".to_sym)
              # puts "#{column_name}"
              # puts obj.send(column_name.to_sym)
            end
          end
        when value.is_a?(Array)
          value.each do |column_name|
            obj_class.all.each do |obj|
              # puts obj.inspect
              # puts "encrypted_#{column_name}"
              # puts obj.send("encrypted_#{column_name}".to_sym)
              # puts "#{column_name}"
              # puts obj.send(column_name.to_sym)
            end
          end
        else
      end
    end
  end

end
