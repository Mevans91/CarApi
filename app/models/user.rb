class User < ApplicationRecord
    validates :email, uniqueness: true
    has_secure_password
  
  
    def generate_token!
      update_attribute :token, AccessToken.new(self).generate
    end
  
    def profile
        {
          first_name: first_name,
          last_name: last_name,
          username: username,
          location: location,
          token: token,
          email: email
        }
    end
end
