# module PorticorBombarder
#   class Invigilator
#
#     def self.inspector!
#       PORTICOR_ENCRYPTED_ATTRIBUTES.each do |key, value|
#         columns = case true
#                     when value.is_a?(Hash)
#                       value.values.flatten
#                     when value.is_a?(Array)
#                       value
#                     else
#                       raise Error.new('while inspecting columns type in schema something went wrong.')
#                   end
#         validate(key, columns)
#       end
#     end
#
#     def self.validate(model_name, columns)
#       columns.each do |column_name|
#         _type = model_name.to_s.classify.constantize.columns_hash[column_name].type
#         unless _type == 'text'
#           puts "Warning: Model #{model_name} column #{column} type #{_type}."
#
#         end
#       end
#     end
#
#   end
# end
#
