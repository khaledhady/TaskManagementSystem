class Project < ActiveRecord::Base
  attr_accessible :end_date, :identifier, :name, :start_date, :ancestry, :parent_id
  has_many :project_user_records, :dependent => :destroy
  has_many :users, :through => :project_user_records
  has_many :releases
  has_ancestry

  validates :name, :identifier, :start_date, :end_date, :presence => true
  validates :identifier,
            :uniqueness => true
  validates :identifier,
            :format => {:with => /^[a-zA-Z\d-]*$/,
            :message => "Identifier must be one word with no spaces"}            

  validate :can_create_as_sub
  validate :valid_dates

  # we have only one level sub project
  def can_create_as_sub
    if not self.parent.nil? and not self.parent.is_root?
      errors[:base] << "You can create only one level sub project" 
    end
  end

  def valid_dates
    if self.end_date < self.start_date
      errors[:base] << "End date must be after start date" 
    end
  end

  def admin
    Project.users.find_by_role(:admin)
  end

  
end
