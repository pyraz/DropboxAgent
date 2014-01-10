class DropboxController < ApplicationController
  def authenticate
    dropbox_authentication_url = "https://www.dropbox.com/1/oauth2/authorize?" +
        "response_type=code&" +
        "client_id=#{ENV['DROPBOX_API_KEY']}&" +
        "redirect_uri=http://localhost:3000/dropbox/authentication_callback"

    redirect_to dropbox_authentication_url
  end

  def authentication_callback
    code = params[:code]
    authorization_information = {
        code: code,
        grant_type: 'authorization_code',
        client_id: ENV['DROPBOX_API_KEY'],
        client_secret: ENV['DROPBOX_API_SECRET'],
        redirect_uri: 'http://localhost:3000/dropbox/authentication_callback'
    }

    token_response = HTTParty.post(
      'https://api.dropbox.com/1/oauth2/token',
      body: authorization_information
    )

    render text: JSON.parse(token_response.body)
  end

  def files
    auth = "Bearer #{ENV['DROPBOX_ACCESS_TOKEN']}"

    response = HTTParty.get(
        'https://api-content.dropbox.com/1/files/dropbox/',
        headers: {'Authorization' => auth }
    )

    render text: response.body
  end

  def info
    auth = "Bearer #{ENV['DROPBOX_ACCESS_TOKEN']}"
    response = HTTParty.get(
        'https://api.dropbox.com/1/account/info',
        headers: {'Authorization' => auth }
    )

    render text: response.body
  end
end