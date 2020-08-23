class Ambition < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_before_end_date
  
  has_many :key_results, dependent: :destroy
  
  private
  
  def start_date_before_end_date
    if start_date >= end_date
      errors.add(:message, "終了日より開始日の日付を早くしてください")
    end
  end
end
