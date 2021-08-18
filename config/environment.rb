# Load the rails application
require File.expand_path('../application', __FILE__)

module I18n
  extend ActionView::Helpers::TagHelper
end

# Initialize the rails application
MySpreeSite::Application.initialize!

ActiveRecord::Base.include_root_in_json = false
