class AuthController < ApplicationController
  include AuthHelper
  require 'securerandom'

 	def gettoken
 # Exchange the auth code for an access token
    token = get_token_from_code params[:code]
    
    # Parse the id token to get the user's information (name, email)
    user_info = get_user_from_id_token(token["id_token"])
    
    # Find the user by email address in the database
    user = User.find_by(email: user_info['preferred_username'])
    if user.nil?
      if user_info['name']
        name_parts = user_info['name'].split(' ')
      else
        name_parts = [nil, nil]
      end
      # If the user doesn't exist, create a new record
      salt = BCrypt::Engine.generate_salt
      random_val = SecureRandom.hex(rand(8..12))
      user = User.create!(first_name: name_parts[0],
      										last_name: name_parts[1],
                         	email: user_info['preferred_username'],
                         	password: BCrypt::Engine.hash_secret(random_val, salt))
    end
    
    # Save the user ID in the session
    session[:user_id] = user.id
    
    redirect_to users_path
  end
end
