unless ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

require 'capybara'
require 'capybara/dsl'
require 'capybara/angular/dsl'
require 'capybara/cucumber'
require 'selenium-webdriver'

$LOAD_PATH << './test_site'
$LOAD_PATH << './lib'

require 'site_prism'
require 'test_site'
require 'sections/people'
require 'sections/no_element_within_section'
require 'sections/container_with_element'
require 'sections/child'
require 'sections/parent'
require 'sections/search_result'
require 'pages/my_iframe'
require 'pages/home'
require 'pages/dynamic_page'
require 'pages/no_title'
require 'pages/page_with_people'
require 'pages/redirect'
require 'pages/section_experiments'

Capybara.configure do |config|
  config.default_driver = :selenium
  config.javascript_driver = :selenium
  config.run_server = false
  config.default_selector = :css
  config.default_max_wait_time = 5
  config.app_host = 'file://' + File.dirname(__FILE__) + '/../../test_site/html'

  # capybara 2.1 config options
  config.match = :prefer_exact
  config.ignore_hidden_elements = false
end

Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.cache.disk.enable'] = false
  profile['browser.cache.memory.enable'] = false
  Capybara::Selenium::Driver.new(app, browser: :firefox, profile: profile)
end

SitePrism.configure do |config|
  config.use_implicit_waits = false
end
