class Technology < ApplicationRecord
  include ActiveModel::Validations

  validates_presence_of :name, presence: {message:'Enter name please'}

  has_and_belongs_to_many :projects
end
