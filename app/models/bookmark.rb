class Bookmark < ApplicationRecord
  belongs_to :image, dependent: :destroy, optional: true

  validates :title, presence: true, length: { maximum: 255 }
  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
