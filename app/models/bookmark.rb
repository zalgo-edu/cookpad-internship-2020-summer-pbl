class Bookmark < ApplicationRecord
  belongs_to :image, dependent: :destroy, optional: true

  validates :title, presence: true, length: { maximum: 255 }
  validates :memo, presence: true, length: { maximum: 512 }
end
