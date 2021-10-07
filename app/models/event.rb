class Event < ApplicationRecord
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :enrollments, dependent: :destroy
  has_many :attendees, through: :enrollments, source: :user

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 200 }
  validates :date, presence: true


  scope :past, -> { where('date < ?', Date.today) }
  scope :upcoming, -> { where('date > ?', Date.today) }

end
