class Api::FbbotController < ApplicationController
  def callback
    if params['hub_verify_token'] === 'LEPrecon37'
      render text: params['hub.challenge']
    else
      render nothing: true, status: ok
    end
  end

  def verify
  end
end