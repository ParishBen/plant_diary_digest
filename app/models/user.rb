class User < ActiveRecord::Base
    has_many :plants
    has_secure_password
end