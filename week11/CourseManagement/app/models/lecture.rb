class Lecture < ActiveRecord::Base
  validates :name, presence: true
  validates :body, presence: true

  has_many :tasks, :dependent => :destroy
end