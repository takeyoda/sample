require 'sinatra'

get '/' do
  "HOGE=#{ENV['HOGE']}"
end
