DropboxAgent::Application.routes.draw do
  get '/dropbox/authenticate' => 'dropbox#authenticate', as: 'dropbox_authentication'
  get '/dropbox/authentication_callback' => 'dropbox#authentication_callback'
  get '/dropbox/files' => 'dropbox#files'
  get '/dropbox/info' => 'dropbox#info'
end
