# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_stories_session',
  :secret      => '09523501c598bd8469e8a98e5bca19bdcbbfcabc139d76941f70863c9894bbe806917007ea2207753c1ee4c4069208dbf7f84b251c9cfe48085c3ef1c54ee495'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
