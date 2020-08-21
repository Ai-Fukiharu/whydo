class DailyResult < ApplicationRecord
  belongs_to :key_result
  
  validates :result, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :result_date, presence: true, uniqueness: { scope: :key_result_id }
  
end
