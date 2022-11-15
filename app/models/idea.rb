class Idea < ApplicationRecord
    belongs_to :user
    
    has_many :reviews, dependent: :destroy

    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user
    
    validates :title, presence: true

    validates :description, presence: true, length: {minimum: 50}
end
