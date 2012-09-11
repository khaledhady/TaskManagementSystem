class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :role

  has_many :project_user_records, :dependent => :destroy
  has_many :projects, :through => :project_user_records

  validates :name, :presence => true
  validates :role, :presence => true

  def role? role
    self.role.to_sym == role 
  end

  def can_create_sub_project_for parent_project
    can? :manage, parent_project and self.projects.include? parent_project
  end
end
