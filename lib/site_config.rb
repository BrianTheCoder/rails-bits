require 'yajl'

module SiteConfig
  extend self
  
  def load_config
    return @_config if @_config
    file = File.new(File.join(Rails.root,'config','keys.json'))
    @_config = Yajl::Parser.parse(file.read, :symbolize_keys => true)[Rails.env.to_sym]
  end
  
  def [](name); load_config[name] end
end