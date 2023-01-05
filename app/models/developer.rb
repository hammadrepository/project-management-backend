class Developer < ApplicationRecord
  validates_presence_of :first_name
  validates :last_name, presence: true
  has_and_belongs_to_many :projects
end
