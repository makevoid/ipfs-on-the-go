
# ---------

recipient_address = "mugwYJ1sKyr8EDDgXtoh8sdDQuNWKYNf88"

# ---------------------------------


# make the DSL methods available in your scope
include Bitcoin::Builder

# the previous transaction that has an output to your address
prev_hash = "6ccb90813afb1ef86cf778be68d43f2625352a03791b22aa4cdb9fbf622a108b"

# the number of the output you want to use
prev_out_index = 0

tx_json = Net::HTTP.get_response(URI "http://webbtc.com/tx/#{prev_hash}.json")
tx_json = tx_json.body

# fetch the tx from whereever you like and parse it
prev_tx = Bitcoin::P::Tx.from_json(tx_json)

# https://webbtc.com/tx/6ccb90813afb1ef86cf778be68d43f2625352a03791b22aa4cdb9fbf622a108b

begin
# the key needed to sign an input that spends the previous output
  key = Bitcoin::Key.from_base58 private_key # TODO load key from disk
rescue ArgumentError => e

  puts "not a valid private key - private_key: #{private_key.inspect} - should be a Base58 encoded pvt key" if DEBUG

  exit 1

end


# create a new transaction (and sign the inputs)
new_tx = build_tx do |t|

  # add the input you picked out earlier
  t.input do |i|
    i.prev_out prev_tx
    i.prev_out_index prev_out_index
    i.signature_key key
  end

  #
  #
  # add an output that sends some bitcoins to another address
  t.output do |o|
    o.value 50000000 # 0.5 BTC in satoshis
    o.script {|s| s.recipient recipient_address  }
  end

  # pay to yourself
  #
  # add another output spending the remaining amount back to yourself
  # if you want to pay a tx fee, reduce the value of this output accordingly
  # if you want to keep your financial history private, use a different address
  t.output do |o|
    o.value 49000000 # 0.49 BTC, leave 0.01 BTC as fee
    o.script {|s| s.recipient key.addr }
  end

end

# examine your transaction. you can relay it through http://test.webbtc.com/relay_tx
# that will also give you a hint on the error if something goes wrong
puts new_tx.to_json
