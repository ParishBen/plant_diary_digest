ENV['SINATRA_ENV'] ||= "development"

require_relative '../secrets'
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
require 'sinatra/base'
require 'sinatra/flash'
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'