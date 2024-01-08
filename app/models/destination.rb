class Destination < ApplicationRecord
    belongs_to :user
    validates :country, :city, :climate, :local_language, :user_id, presence: true
end
