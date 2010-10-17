# Use this hook to configure devise mailer, warden hooks and so forth. The first
# four configuration values can also be set straight in your models.
Devise.setup do |config|
  # ==> Mailer Configuration
  # Configure the e-mail address which will be shown in DeviseMailer.
  config.mailer_sender = "cicerone@beerspot.in"

  # ==> ORM configuration
  # Load and configure the ORM. Supports :active_record (default) and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'devise/orm/mongo_mapper'
  # ==> Configuration for :database_authenticatable
  # For bcrypt, this is the cost for hashing the password and defaults to 10. If
  # using other encryptors, it sets how many times you want the password re-encrypted.
  config.stretches = 10
  config.encryptor = :bcrypt
  config.pepper = "f0484a3ed9b60f04dbcec4fbf70d0c0f87d62e09804a7cbb1e73d6bf194c2e3ea8ade4d4f955494f24e42fb073b1d6818fc51238172ca6012d655dc02de849d4"
  config.confirm_within = 2.days
  # ==> Configuration for :rememberable
  # The time the user will be remembered without asking for credentials again.
  config.remember_for = 2.weeks
  # If true, a valid remember token can be re-used between multiple browsers.
  config.remember_across_browsers = true
  # If true, extends the user's remember period when remembered via cookie.
  config.extend_remember_period = false
  # ==> Configuration for :token_authenticatable
  # Defines name of the authentication token params key
  config.token_authentication_key = :auth_token

  # ==> Navigation configuration
  # Lists the formats that should be treated as navigational. Formats like
  # :html, should redirect to the sign in page when the user does not have
  # access, but formats like :xml or :json, should return 401.
  # If you have any extra navigational formats, like :iphone or :mobile, you
  # should add them to the navigational formats lists. Default is [:html]
  config.navigational_formats = [:html, :mobile]
end
