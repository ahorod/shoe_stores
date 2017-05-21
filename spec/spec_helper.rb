ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

DB = PG.connect({:dbname => "shoe_stores_test"})
RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stores *;")
    DB.exec("DELETE FROM brands *;")
    DB.exec("DELETE FROM brands_stores *;")
  end
end
