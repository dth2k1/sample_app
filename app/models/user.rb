class User < ApplicationRecord
    attr_accessor :remember_token
    before_save {self.email = email.downcase} #callback #! to modify email original
    validates :name , presence: true , length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email,presence: true , length: {maximum: 255} , format: {with: VALID_EMAIL_REGEX} ,uniqueness: { case_sensitive: false }#khong duoc giong nhau ke ca in hoa in thuong
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

    class << self
    def digest(string) #seft la User class no refrence den       #thuat toanmahoa
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
        end
def new_token
SecureRandom.urlsafe_base64  #generate token
end
end
def remember
    self.remember_token = User.new_token  #assign remember_token attr  = new token
    update_attribute(:remember_digest, User.digest(remember_token)) #create remember digest base hash remmember_token
end
# Returns true if the given token matches the digest.
def authenticated?(remember_token)
    return false if remember_digest.nil?  #return false if remmber rong
    BCrypt::Password.new(remember_digest).is_password?(remember_token)#compare decrypt password_digest vs remember_token
    end

    #logout
    def forget
        update_attribute(:remember_digest,nil)
    end
end
