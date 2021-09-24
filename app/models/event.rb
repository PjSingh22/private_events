class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :attendee, class_name: 'User'
  has_many :enrollments
  has_many :attendees, through: :enrollments, source: :user
end
