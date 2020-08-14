class Ambition < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :start_date, presence: true
  validates :end_date, presence: true
end
