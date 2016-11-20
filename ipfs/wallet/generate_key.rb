module GenerateKey

  def load_private_key
    private_key = File.read private_key_path
    private_key.strip
  end

  def generate_and_save_key
    keypair = Bitcoin::Key.generate
    private_key = keypair.priv

    # private_key = keypair.priv

    File.open(private_key_path, "w") do |file|
      file.write private_key
    end

    private_key
  end

  def private_key_path
    flag = test_env? ? "-test" : ""
    "#{PATH}/../config/btc_private_key#{flag}.txt"
  end

  # private

  def test_env?
    ENV["RACK_ENV"] == "test"
  end

end
