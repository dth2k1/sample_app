class User < ApplicationRecord
    has_many :microposts
    attr_accessor :remember_token,  :activation_token
    before_create :create_activation_digest
    before_save :downcase_email #callback #! to modify email original
    validates :name , presence: true , length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email,presence: true , length: {maximum: 255} , format: {with: VALID_EMAIL_REGEX} ,uniqueness: { case_sensitive: false }#khong duoc giong nhau ke ca in hoa in thuong
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 },allow_nil: true

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

#tao ra token digest
def remember
    self.remember_token = User.new_token  #assign remember_token attr  = new token
    update_attribute(:remember_digest, User.digest(remember_token)) #create remember digest base hash remmember_token
end
# Returns true if the given token matches the digest.
def authenticated?(attribute,token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?  #return false if remmber rong
    BCrypt::Password.new(digest).is_password?(token)#compare decrypt password_digest vs remember_token
    end

    #logout
    def forget
        update_attribute(:remember_digest,nil)
    end
    def feed
        Micropost.where("user_id =?",id)
    end
    private
   

    #tao ra token ma hoa
    def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
    end

    #DOWNCASE EMAIL
    def downcase_email
        self.email = email.downcase

    end
    def activate
        update_attribute(:activated, true)
        update_attribute(:activated_at, Time.zone.now)
        #cach 2
        #update_columns(activated:true, activated_at: Time.zone.now)
        end
        # Sends activation email.
def send_activation_email
    UserMailer.account_activation(self).deliver_now
    end
    
end
