class Task < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true

  belongs_to :lecture
  has_many :solutions, :dependent => :destroy

  scope :for_lecture, -> (lecture) { Task.where(lecture_id: lecture) }
end