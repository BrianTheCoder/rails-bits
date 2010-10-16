git :init

gem 'bson_ext', :require => 'bson'
gem 'compass'
gem 'dalli'
gem 'devise'
gem 'escape_utils'
gem 'haml'
gem 'mm-devise'
gem 'mongo_mapper'
gem 'omniauth'
gem 'redis'
gem 'redis-namespace' 
gem 'system_timer'
gem 'typhoeus'
gem 'vanity', :git => 'git://github.com/BrianTheCoder/vanity.git'
gem 'yajl-ruby', :require => 'yajl'

file '.gitignore', <<-FILE
  .DS_Store
  log/*.log
  tmp/**/*
  config/database.yml
  db/*.sqlite3
  public/uploads/*
  vendor/*
  !vendor/cache
FILE

services = {}

puts "Enter twitter key"
twitter_key = gets.chomp
unless twitter_key.blank?
  services[:twitter][:key] = twitter_key
  puts "Enter twitter secret"
  services[:twitter][:secret] = gets.chomp
end

puts "Enter facebook app_id"
fb_app_id = gets.chomp
unless fb_app_id.blank?
  services[:facebook][:app_id] = fb_app_id
  puts "Enter facebook key"
  services[:facebook][:key] = get.chomp
  puts "Enter facebook secret"
  services[:facebook][:services] = gets.chomp
end

plugin 'mobile-fu', :git => 'git://github.com/brendanlim/mobile-fu.git'

initializer 'mongo_mapper.rb', <<-EOF
  if ENV['MONGOHQ_URL']
    MongoMapper.config = {Rails.env => {'uri' => ENV['MONGOHQ_URL']}}
  else
    MongoMapper.config = {Rails.env => {'uri' => 'mongodb://localhost/#{app_name}'}}
  end

  MongoMapper.connect(Rails.env)
EOF

initializer 'escape_utils.rb', <<-EOF
  require 'escape_utils/html/rack' # to patch Rack::Utils
  require 'escape_utils/html/erb' # to patch ERB::Util
  require 'escape_utils/html/cgi' # to patch CGI
EOF

initializer 'omniauth.rb', <<-EOF
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, SiteConfig[:twitter][:key], SiteConfig[:twitter][:secret]
    provider :github, SiteConfig[:github][:app_id], SiteConfig[:github][:secret]
    provider :open_id, OpenID::Store::Memcache.new(Dalli::Client.new), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
    provider :open_id, OpenID::Store::Memcache.new(Dalli::Client.new), :name => 'yahoo', :identifier => 'http://yahoo.com/'
  end
EOF

run 'compass init rails'
run 'rails g devise:install'