class Photo < ActiveRecord::Base
  validates :url, presence: true
  validates :title, presence: true
end