require 'http'
require 'json'
require 'sinatra'

helpers do
  def eval_in(code, language)
    result = HTTP.with_headers(:'User-Agent' => 'tejasmanohar/pasterunner')
     .post('https://eval.in/', :form => {
       :utf8 => 'λ',
       :code => code,
       :execute => 'on',
       :lang => language
     })
    location = result['location']
    data = JSON.parse HTTP.get(location + '.json')
    data['output']
  end
end

post '/exec' do
  output = eval_in params[:code], params[:language]
  { :stdout => output }
end
