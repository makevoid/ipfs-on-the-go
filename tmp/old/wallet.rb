require_relative 'env'

Bitcoin.network = :bitcoin


keypair = Bitcoin::Key.generate

puts "keypair 1:"
p keypair.priv





# ---

keypair = Bitcoin::generate_key

puts "keypair 2:"
p keypair[0]
