class Photo < ApplicationRecord
    belongs_to :destination
    validates :image, :description, presence: true
    validates :description, length: { minimum: 8 }
end
