class Project < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :technologies_id,:project_id , presence: true, on: :addTechnology
  validates :developers_id,:project_id , presence: true, on: :addDeveloper
  validates_date :start_date
  # validates_date on_or_after: :start_date, on_or_after_message: 'end date must be greater than start date'

  has_and_belongs_to_many :developers
  has_and_belongs_to_many :technologies
  acts_as_paranoid
end
