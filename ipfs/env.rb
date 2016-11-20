path = File.expand_path "../", __FILE__

PATH = path

# DEBUG = false
DEBUG = true # TODO: switch to DEBUG false before releasing!

APP_ENV = ENV["RACK_ENV"] || "development"

puts "loaded env: #{APP_ENV}" if DEBUG

require 'bundler'
Bundler.require :default

# w/o bundler:
#
# require 'ipfs/client'


# ---


# require libs

# require_relative 'ipfs-rb/lib/ipfs_add'

require_relative 'wallet/generate_key'
require_relative 'wallet/wallet'


# ---


# IPFS client

IF = IPFS::Client.default
# IPFS_CLIENT
