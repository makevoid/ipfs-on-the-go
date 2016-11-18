require 'sinatra'

get "/" do
  content_type :json
  File.read "./ui_jasonette/ui_ipfs.json"
end

run Sinatra::Application
