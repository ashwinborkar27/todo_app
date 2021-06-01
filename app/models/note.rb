class Note < ApplicationRecord
  belongs_to :user
  has_many :profiles
    scope :report, -> { where(selector: "Report") }
	scope :task, -> { where(selector: "Task") }
	scope :personal, -> { where(selector: "Personal") }
  
  
end
