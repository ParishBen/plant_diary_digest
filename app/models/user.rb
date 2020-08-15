class User < ActiveRecord::Base
    has_many :plants
    has_many :logs, through: :plants
    has_many :tips
    has_secure_password
end