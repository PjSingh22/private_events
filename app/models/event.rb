class Event < ApplicationRecord
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :enrollments
  has_many :attendees, through: :enrollments, source: :attendee
end
