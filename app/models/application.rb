class Application < ApplicationRecord
  belongs_to :user
  belongs_to :gallery

  validates :user_id, presence: true
  validates :gallery_id, presence: true

end
