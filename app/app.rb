require 'sinatra'

configure { set :server, :puma }

get '/' do
  "HOGE=#{ENV['HOGE']}"
end

get '/sleep' do
  sec = (params['sleep']&.to_i || 0).clamp(1, 305)
  sleep sec
  "sleep #{sec}"
end
