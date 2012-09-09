class Project < ActiveRecord::Base
  attr_accessible :end_date, :identifier, :name, :start_date, :ancestry
  has_many :project_user_records, :dependent => :destroy
  has_many :users, :through => :project_user_records
  has_ancestry
  # after_save :addToProjectUsers

  def admin
    Project.users.find_by_role(:admin)
  end

  
end
