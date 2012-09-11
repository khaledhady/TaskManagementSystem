class Release < ActiveRecord::Base
  attr_accessible :end_date, :project_id, :start_date, :version
  belongs_to :project

  validates_presence_of :start_date, :end_date, :version, :project_id

  validate :valid_dates

  def valid_dates
    if self.end_date < self.start_date
      errors[:base] << "End date must be after start date" 
    end
  end

end
