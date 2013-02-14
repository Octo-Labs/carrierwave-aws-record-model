require "carrierwave/aws/record/model/version"
require 'carrierwave/validations/active_model'
require "aws-sdk"
require 'simple_callbacks'


module CarrierWave
  module AWS
    module Record
      module Model

        include CarrierWave::Mount

        ##
        # See +CarrierWave::Mount#mount_uploader+ for documentation
        #
        def mount_uploader(column, uploader=nil, options={}, &block)
          string_attr options[:mount_on] || "#{column}_store".to_sym
          super

          include CarrierWave::Validations::ActiveModel
          include CarrierWave::AWS::Record::Model::Uploaders

          #validates_integrity_of column if uploader_option(column.to_sym, :validate_integrity)
          #validates_processing_of column if uploader_option(column.to_sym, :validate_processing)
          #validates_download_of column if uploader_option(column.to_sym, :validate_download)

          after_save :"store_#{column}!"
          before_save :"write_#{column}_identifier"
          after_destroy :"remove_#{column}!"
          before_update :"store_previous_model_for_#{column}"
          after_save :"remove_previously_stored_#{column}"

          class_eval <<-RUBY, __FILE__, __LINE__+1
            def #{column}_changed?
              #{column}_store_changed?
            end
          RUBY
        end

      end
    end
  end
end


module CarrierWave::AWS::Record::Model::Uploaders
  def read_uploader(name)
    store_name = "#{name}_store".to_sym
    self[store_name]
  end

  def write_uploader(name,uploader)
    store_name = "#{name}_store".to_sym
    self[store_name]= uploader
  end
end

# Instance hook methods for the Sequel 3.x
module CarrierWave::AWS::Record::Model::Hooks
  #def after_save
    #return false if super == false
    #self.class.uploaders.each_key {|column| self.send("store_#{column}!") }
  #end

  #def before_save
    #return false if super == false
    #self.class.uploaders.each_key {|column| self.send("write_#{column}_identifier") }
  #end

  #def before_destroy
    #return false if super == false
    #self.class.uploaders.each_key {|column| self.send("remove_#{column}!") }
  #end
end

# Instance validation methods for the Sequel 3.x
module CarrierWave::AWS::Record::Model::Validations
end

AWS::Record::Model.send(:extend, CarrierWave::AWS::Record::Model)
