class Note < ApplicationRecord
  belongs_to :user
    scope :report, -> { where(selector: "Report") }
	scope :task, -> { where(selector: "Task") }
	scope :personal, -> { where(selector: "Personal") }
  
end
