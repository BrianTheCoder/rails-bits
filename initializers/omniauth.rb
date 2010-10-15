Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, SiteConfig[:twitter][:key], SiteConfig[:twitter][:secret]
  provider :github, SiteConfig[:github][:app_id], SiteConfig[:github][:secret]
  provider :open_id, OpenID::Store::Memcache.new(Dalli::Client.new), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :open_id, OpenID::Store::Memcache.new(Dalli::Client.new), :name => 'yahoo', :identifier => 'http://yahoo.com/'
end