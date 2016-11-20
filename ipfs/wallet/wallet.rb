require_relative '../env'

Bitcoin.network = :bitcoin


# tmp - path
# path = File.expand_path "../../../", __FILE__
path = PATH

# load key

# private_key = "92ZRu28m2GHSKaaF2W7RswJ2iJYpTzVhBaN6ZLs7TENCs4b7ML8"
# private_key = File.open "~/.btc_private_key"


extend GenerateKey

private_key = load_private_key

if private_key == ""
  private_key = generate_and_save_key
end

# ---------------------------------

puts "Private Key: #{private_key}" if DEBUG
