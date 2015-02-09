# Load the Rails application.
require File.expand_path('../application', __FILE__)

# following http://tammersaleh.com/posts/managing-heroku-environment-variables-for-local-development/
# suggestions on setting up secret keys
# require File.join(File.dirname(__FILE__), 'boot')

# # Load heroku vars from local file
# heroku_env = File.join(Rails.root, 'config', 'heroku_env.rb')
# load(heroku_env) if File.exists?(heroku_env)

# Initialize the Rails application.
Rails.application.initialize!
