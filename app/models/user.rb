class User < ApplicationRecord
    before_save {self.email = email.downcase} #callback #! to modify email original
    validates :name , presence: true , length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email,presence: true , length: {maximum: 255} , format: {with: VALID_EMAIL_REGEX} ,uniqueness: { case_sensitive: false }#khong duoc giong nhau ke ca in hoa in thuong
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end
