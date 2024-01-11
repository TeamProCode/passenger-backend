class Destination < ApplicationRecord
    belongs_to :user
    has_many :photos
    validates :location, :climate, :local_language, :image, :description, :user_id, presence: true
end
