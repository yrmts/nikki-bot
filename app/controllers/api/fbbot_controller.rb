class Api::FbbotController < ApplicationController
  def callback
    if entry = params['entry']
      messaging_events = try[0]['messaging']
      messaging_events.select{ |event| event['message'].present? }.each do |event|
        sender_id = event['sender']['id']
        text = event['message']['text'] if event['message']['text'].present?

        parrot = Parrot.new(PAGE_ACCESS_TOKEN)
        parrot.post(sender_id, text)
      end
    end
  end

  def verify
    if params['hub.verify_token'] == 'LEPrecon37'
      render text: params['hub.challenge']
    else
      render nothing: true, status: :ok
    end
  end
end
