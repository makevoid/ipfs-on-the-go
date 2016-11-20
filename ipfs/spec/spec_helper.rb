ENV["RACK_ENV"] = "test"

# rspec configs



# app env

require_relative '../env'

# env loaded check

raise "No PATH found, please define the PATH variable" unless defined?("PATH")


# require single files/libs

# require_relative '../../wallet/wallet'


# spec extensions / runners

RUN_WALLET = -> {
  out = `ruby #{PATH}/wallet/wallet.rb`
  puts out
  out
}
