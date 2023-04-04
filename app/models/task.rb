class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  validates :name, presence: true
  validates :description , presence: true
  validates :author, presence: true
  validates :description, length: { maximum: 500 }

  state_machine :new_task, :in_qa, :in_code_review => :in_development do
    event :develop do
      transition :new_task, :in_qa, :in_code_review => :in_development
    end

    event :in_test do
      transition :in_development => :in_qa
    end

    event :review do
      transition :in_qa => :in_code_review  
    end

    event :can_be_released do
      transition :in_code_review => :ready_for_release
    end

    event :finished do
      transition :ready_for_release => :released
    end
  
    event :goes_to_archive do
      transition :new_task, :released => :archived
    end
  end
end