# Load the rails application
require File.expand_path('../application', __FILE__)
require 'pdf/writer'
Mime::Type.register 'application/pdf', :pdf
# Initialize the rails application
ModelCustmoers::Application.initialize!
