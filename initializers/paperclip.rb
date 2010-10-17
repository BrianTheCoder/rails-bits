module Paperclip
  class << self
    def logger #:nodoc:
      MongoMapper.logger
    end
  end
    
  module ClassMethods
    def has_attached_file name, options = {}
      include InstanceMethods
      
      key :"#{name}_file_name",         String
      key :"#{name}_content_type",      String
      key :"#{name}_file_size",         Integer
      key :"#{name}_updated_at",        Time

      write_inheritable_attribute(:attachment_definitions, {}) if attachment_definitions.nil?
      attachment_definitions[name] = {:validations => []}.merge(options)

      after_save :save_attached_files
      before_destroy :destroy_attached_files

      define_callbacks :before_post_process, :after_post_process
      define_callbacks :"before_#{name}_post_process", :"after_#{name}_post_process"
     
      define_method name do |*args|
        a = attachment_for(name)
        (args.length > 0) ? a.to_s(args.first) : a
      end

      define_method "#{name}=" do |file|
        attachment_for(name).assign(file)
      end

      define_method "#{name}?" do
        attachment_for(name).file?
      end
      
      # validates_each name, :logic => lambda {|record, attr, value|
      #   attachment = record.attachment_for(name)
      #   attachment.send(:flush_errors) unless attachment.valid?
      # }
    end
  end
end

Paperclip.interpolates :mongo do |attachment, style|
  id = attachment.instance.id.to_s
  id.split(/(\w{2})(\w{2})(\w{2})(\w{2})(\w{2})(.*)/)[1,3].inject('/'){|a,b| a += "#{b}/" } + id
end

Paperclip.interpolates :exdown do |attachment, style|
  attachment.original_filename.split('.').last.downcase
end


MongoMapper::Document.append_extensions Paperclip::ClassMethods
MongoMapper::Document.append_inclusions Paperclip::CallbackCompatability::Rails21