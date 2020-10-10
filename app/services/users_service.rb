class UsersService
    def self.login(username, password)
        return false unless user = User.find_by(username:username).try(:authenticate, password)
        user.generate_token!
        user
    end

    def self.register(email, first_name, last_name, location, username, password, password_confirmation)
        user = User.new({
            email: email,
            username: username,
            first_name: first_name,
            last_name: last_name,
            location: location,
            password_digest: password,
            password_confirmation: password_confirmation
        })
        return false unless user.valid?
        user.save
        user.generate_token!
        user
    end

    def self.logout(user)
        user.update(token: nil)
    end
end