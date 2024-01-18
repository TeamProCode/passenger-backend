class Destination < ApplicationRecord
    belongs_to :user
    has_many :photos
    validates :location, :climate, :local_language, :image, :description, presence: true
end
