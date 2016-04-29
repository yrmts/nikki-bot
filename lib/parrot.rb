require 'faraday'
require 'faraday_middleware'

class Parrot
  ENDPOINT = 'https://graph.facebook.com/v2.6/me/messages'

  def initialize(page_token, proxy = nil)
    @page_token = page_token
    @proxy = proxy
  end

  def post(text)
    message_data = {text: text}
    client = Faraday.new(url: ENDPOINT) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Faraday.default_adapter
    end

    res = client.post do |request|
      request.url "?access_token=#{@page_token}"
      request.headers = {
        'Content-type' => 'application/json; charset=UTF-8'
      }
      request.body = data
    end
  end

  def send_message(recipient_id, text)
    post({
      recipient: {id: recipient_id},
      message: {text: text}
    })
  end
end
