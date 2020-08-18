class Plant < ActiveRecord::Base
    belongs_to :user
    has_many :logs
end