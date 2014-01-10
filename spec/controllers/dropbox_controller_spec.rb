require 'spec_helper'

describe DropboxController do
  describe '#authenticate' do
    it 'should authenticate with Dropbox' do
      get :authenticate

      dropbox_url = "https://www.dropbox.com/1/oauth2/authorize?" +
          "response_type=code&" +
          "client_id=#{ENV['DROPBOX_API_KEY']}&" +
          "redirect_uri=http://localhost:3000/dropbox/authentication_callback"
      expect(response).to redirect_to dropbox_url
    end
  end
end
