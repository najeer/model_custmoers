ActionMailer::Base.smtp_settings = {
  :address              => "smtp.sendgrid.net",
  :port                 => 587,
  :domain               => "siliconprime.com",
  :user_name            => "siliconprime",
  :password             => "test123",
  :authentication       => "plain",
  :enable_starttls_auto => false,
  :raise_delivery_errors => true
}
ActionMailer::Base.default_url_options[:host] = "localhost:3000"