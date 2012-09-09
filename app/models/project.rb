class Project < ActiveRecord::Base
  attr_accessible :end_date, :identifier, :name, :start_date
  has_and_belongs_to_many :users
end
