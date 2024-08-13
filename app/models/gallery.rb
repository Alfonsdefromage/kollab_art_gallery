class Gallery < ApplicationRecord
  belongs_to :user
  has_many :applications, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :address, presence: true
  validates :description, length: { maximum: 500 }
  validates :availability, inclusion: { in: [true, false] }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
end
