# Load the Rails application.
require_relative 'application'

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD'],
  :domain => 'pacific-thicket-49521.herokuapp.com',
  :host => 'pacific-thicket-49521.herokuapp.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

# Initialize the Rails application.
Rails.application.initialize!



