class Solution < ActiveRecord::Base
  validates :answer, presence: true

  belongs_to :task

  scope :for_task, -> task { Solution.where(task_id: task) }
end