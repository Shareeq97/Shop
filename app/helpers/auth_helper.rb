module AuthHelper

  # App's client ID. Register the app in Application Registration Portal to get this value.
  CLIENT_ID = 'da7a5058-9238-4fe5-9dfa-d12108d05218'
  # App's client secret. Register the app in Application Registration Portal to get this value.
  CLIENT_SECRET = '.6dNQ@_ns[9x0x6Yv4k9Q1jyE=8b-B@h'

  # Scopes required by the app
  SCOPES = [ 'openid',
           'profile',
           'offline_access',
           'User.Read',
           'Mail.Read' ]

  REDIRECT_URI = 'http://localhost:3000/authorize' # Temporary!

  # Generates the login URL for the app.
  def get_login_url
    client = OAuth2::Client.new(CLIENT_ID,
                                CLIENT_SECRET,
                                :site => 'https://login.microsoftonline.com',
                                :authorize_url => '/common/oauth2/v2.0/authorize',
                                :token_url => '/common/oauth2/v2.0/token')

   	login_url = client.auth_code.authorize_url(:redirect_uri => authorize_url,
                                       :scope => SCOPES.join(' '))
 	end

 	def get_token_from_code(auth_code)
	  client = OAuth2::Client.new(CLIENT_ID,
	                              CLIENT_SECRET,
	                              :site => 'https://login.microsoftonline.com',
	                              :authorize_url => '/common/oauth2/v2.0/authorize',
	                              :token_url => '/common/oauth2/v2.0/token')

	  token = client.auth_code.get_token(auth_code,
	                                     :redirect_uri => authorize_url,
	                                     :scope => SCOPES.join(' '))
	end

	def get_access_token
	  # Get the current token hash from session
	  token_hash = session[:azure_token]

	  client = OAuth2::Client.new(CLIENT_ID,
	                              CLIENT_SECRET,
	                              :site => 'https://login.microsoftonline.com',
	                              :authorize_url => '/common/oauth2/v2.0/authorize',
	                              :token_url => '/common/oauth2/v2.0/token')

	  token = OAuth2::AccessToken.from_hash(client, token_hash)

	  # Check if token is expired, refresh if so
	  if token.expired?
	    new_token = token.refresh!
	    # Save new token
	    session[:azure_token] = new_token.to_hash
	    access_token = new_token.token
	  else
	    access_token = token.token
	  end
	end

	def get_user_from_id_token(id_token)
	  # JWT is in three parts, separated by a '.'
	  token_parts = id_token.split('.')
	  # Token content is in the second part
	  encoded_token = token_parts[1]
  
	  # It's base64, but may not be padded
	  # Fix padding so Base64 module can decode
	  leftovers = token_parts[1].length.modulo(4)
		  if leftovers == 2
		    encoded_token += '=='
		  elsif leftovers == 3
		    encoded_token += '='
		  end
  
	  # Base64 decode (urlsafe version)
	  decoded_token = Base64.urlsafe_decode64(encoded_token)
  
	  # Load into a JSON object
	  jwt = JSON.parse(decoded_token)
 
	end
end
