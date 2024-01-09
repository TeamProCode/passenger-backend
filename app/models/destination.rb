class Destination < ApplicationRecord
    belongs_to :user
    validates :location, :climate, :local_language, :image, :description, :user_id, presence: true
end
