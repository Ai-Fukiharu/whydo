class KeyResult < ApplicationRecord
  belongs_to :ambition
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :numerical_goal, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than: 500 }

  has_many :daily_results, dependent: :destroy
end
