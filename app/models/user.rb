class User < ApplicationRecord
  after_initialize :set_default_role, :if => :new_record?
  validates_presence_of :first_name, :last_name, :sex, :birthdate, :address
  validates :phone_number , :presence => true,
                            :numericality => true,
                            :length => { :minimum => 10, :maximum => 15 }


  has_many :parents, class_name: "User", foreign_key: "children_id" #, before_add: :validate_parents
  belongs_to :children, class_name: "User", optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :admin]
  enum sex: [:male, :female]
  
  def to_s
  	full_name
  end

  def set_default_role
    self.role ||= :user
  end

  def full_name
  	first_name + " " + last_name
  end

  def age
  	now = Time.now.utc.to_date
  	now.year - birthdate.year - ((now.month > birthdate.month || (now.month >= birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

end
